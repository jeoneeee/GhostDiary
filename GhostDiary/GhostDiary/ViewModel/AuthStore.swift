//
//  AuthStore.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import AuthenticationServices

import GoogleSignIn
import Firebase

// MARK: - 로그인 결과 코드
/// 각각의 case는 다음과 같다.
/// 성공, 이메일이 다른경우, 비밀번호가 다른 경우,
/// 서버 요청이 너무 많은 경우,
/// 유저가 존재하지 않는 경우

enum AuthLoginCode: Int {
    case success = 200
    case inVaildEmail = 17008
    case inVaildPassword = 17009
    case muchRequest = 17000
    case notExsitUser = 17011
    case unkownError = 125124
}

enum LoginStatus {
    case defatult
    case registered
    case logined
}

class AuthStore: ObservableObject {
    var handel: AuthStateDidChangeListenerHandle?
    var user: FirebaseAuth.User?
    
    private lazy var databaseReference: CollectionReference? = {
        let reference = Firestore.firestore().collection("users")
        return reference
    }()
    
    @Published var loginStatus: LoginStatus = .defatult
    
    /// 이전에 로그인을 했다면 클로저의 user 매개변수에 마지막에 로그인했던 유저의 정보가 담겨져있음
    func startListeners() {
        self.handel = Auth.auth().addStateDidChangeListener { auth, user in
            if let user {
                if self.loginStatus == .defatult {
                    self.loginStatus = .logined
                }
                self.user = user
                //LoginStores. = user.uid
                print("유저 변화 감지 시작 - startListeners")
                print("uid: \(user.uid), email: \(user.email ?? "UnKnown")")
            }
        }
    }
    
    
    func disConnectListeners() {
        Auth.auth().removeStateDidChangeListener(self.handel!)
    }
    
    func register(email: String, password: String) async -> Bool {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            await addUsers(email: email, password: password, createdAt: TimeData.getTimeStrings())
            DispatchQueue.main.async {
                self.loginStatus = .registered
            }
            return true
        } catch {
            print("User Register Error: \(error)")
            return false
        }
    }
    
    // MARK: - 반환 하는 Int값은 에러코드
    func signIn(email: String, password: String) async -> AuthLoginCode {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            self.user = authResult.user
            DispatchQueue.main.async {
                self.loginStatus = .logined
            }
            print("로그인한 유저 이메일: \(String(describing: self.user?.email)), uid: \(String(describing: self.user?.uid))")
            return .success
        }
        catch {
            print("Sign In Error : \(error)")
            let code = (error as NSError).code
            return AuthLoginCode(rawValue: code) ?? .unkownError
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            print("로그 아웃 실행됨")
            self.user = nil
        } catch {
            print("LogOutError: \(error)")
        }
    }
}

// MARK: - 회원가입 한 유저 DB에 등록
extension AuthStore {
    func addUsers(email: String, password: String, createdAt: String) async {
        do {
            if let user = self.user {
                print("self user가 nil이 아님")
                try await databaseReference?.document(user.uid).setData([
                    "id": user.uid,
                    "email": email,
                    "password": password,
                    "timestamp": createdAt
                ])
            }
        } catch {
            print("DB Add User Error: \(error)")
        }
    }
}

// MARK: - Google로 로그인 
extension AuthStore {
     func googleSignIn() {
       if GIDSignIn.sharedInstance.hasPreviousSignIn() {
         GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
             authenticateUser(for: user, with: error)
         }
       } else {
         guard let clientID = FirebaseApp.app()?.options.clientID else { return }
         let configuration = GIDConfiguration(clientID: clientID)

         guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
         guard let rootViewController = windowScene.windows.first?.rootViewController else { return }

         GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
           authenticateUser(for: user, with: error)
         }
       }
     }

     private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
       if let error = error {
         print(error.localizedDescription)
         return
       }

       guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }

       let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

       Auth.auth().signIn(with: credential) { [unowned self] (user, error) in
         if let error = error {
           print(error.localizedDescription)
         } else {
             print("Login한 유저의 uid: \(user?.user.uid)")
         }
       }
     }

     func googleSignOut() {
       GIDSignIn.sharedInstance.signOut()

       do {
         try Auth.auth().signOut()

       } catch {
         print(error.localizedDescription)
       }
     }
 }
