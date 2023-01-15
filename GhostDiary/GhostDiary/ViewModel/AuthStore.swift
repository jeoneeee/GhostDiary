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

enum DuplicatedEmail {
    case duplicated
    case notdupleciated
}

class AuthStore: ObservableObject {
    var handel: AuthStateDidChangeListenerHandle?
    
    private lazy var databaseReference: CollectionReference? = {
        let reference = Firestore.firestore().collection("users")
        return reference
    }()
    
    @Published var loginStatus: LoginStatus = .defatult
    var user: User? = User(id: "", email: "", questionNum: "", lastLoginTime: Date(), timestamp: Date()) // default
    
    /// 이전에 로그인을 했다면 클로저의 user 매개변수에 마지막에 로그인했던 유저의 정보가 담겨져있음
    func startListeners() {
        self.handel = Auth.auth().addStateDidChangeListener { auth, user in
            if let user {
                print("유저 변화 감지 시작 - startListeners")
                print("uid: \(user.uid), email: \(user.email ?? "UnKnown"), date: \(user.metadata.creationDate)")
                
                switch self.loginStatus {
                case .registered:
                    return
                default:
                    Task {
                        await self.readUser(user.uid)
                    }
                    self.loginStatus = .logined
                }
            }
        }
    }
    
    func disConnectListeners() {
        Auth.auth().removeStateDidChangeListener(self.handel!)
    }
    
    func register(email: String, password: String) async -> Bool {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            self.loginStatus = .registered
            await setUser(authResult.user.uid, email: email, questionNum: "1",createdAt: authResult.user.metadata.creationDate ?? Date(), lastloginTime: Date())
            
            await addUsers()
            return true
        } catch {
            print("User Register Error: \(error)")
            return false
        }
    }
    // 반환 값이 비어있으면 이미 가입된 이메일이 아님
    func checkduplicationEmail(email: String) async -> DuplicatedEmail {
        do {
            let emailStrings = try await Auth.auth().fetchSignInMethods(forEmail:  email)
            return (emailStrings.isEmpty) ? .notdupleciated : .duplicated
        } catch {
            print("중복 이메일 확인 에러: \(error.localizedDescription)")
        }
        return .duplicated
    }
    
    // MARK: - 반환 하는 Int값은 에러코드
    func signIn(email: String, password: String) async -> AuthLoginCode {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)

            await readUser(authResult.user.uid)
            
            DispatchQueue.main.async {
                self.loginStatus = .logined
            }
            
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
    
    func getErrorMessage(loginCode: AuthLoginCode) -> String {
        switch loginCode {
        case .success:
            return "로그인 성공"
        case .inVaildEmail:
            return "올바르지 않은 이메일 입니다."
        case .inVaildPassword:
            return "올바르지 않은 비밀번호 입니다."
        case .muchRequest:
            return "현재 서버에 너무 많은 요청이 있습니다."
        case .notExsitUser:
            return "존재하지 않는 유저 입니다."
        case .unkownError:
            return "알수 없는 오류 입니다."
        }
    }
}
//MARK: - 로그인한 유저의 정보를 저장하는 메소드
/// 로그인한 유저의 정보를 관리하는 객체를 저장하는 역할을 수행합니다.
/// - Parameter uid: 로그인한 유저의 uid
/// - Parameter email: 로그인한 유저의 email
/// - Parameter 로그인한 유저의 회원가입 날짜
///
/// 수정해야 함 -> loginTime을 이전에 로그인한 시간으로 authResult.user.metadata.lastSignInDate
extension AuthStore {
    func setUser(_ uid: String, email: String, questionNum: String ,createdAt: Date, lastloginTime: Date) async {
        self.user = User(id: uid,
                         email: email,
                         questionNum: questionNum,
                         lastLoginTime: lastloginTime,
                         timestamp: createdAt)
        
        print("set User: \(self.user)")
    }
}

// MARK: - 회원가입 한 유저 DB에 등록
extension AuthStore {
    func addUsers() async {
        do {
            if let db = databaseReference, let user = self.user {
                print("self user가 nil이 아님")
                try await db.document(user.id).setData([
                    "id": user.id,
                    "email": user.email,
                    "questionNum": "1",
                    "lastLoginTime": user.lastLoginTime,
                    "timestamp": user.timestamp
                ])
            }
        } catch {
            print("DB Add User Error: \(error)")
        }
    }
    
    func readUser(_ uid: String) async {
        if let db = databaseReference {
            do {
                let document = try await db.document(uid).getDocument()

                if document.exists {
                    guard let data = document.data() else { return }
                    
                    let id = data["id"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let questionNum = data["questionNum"] as? String ?? "1"
                    
                    let lastLoginTime = data["lastLoginTime"] as? Timestamp ?? Timestamp()
                    let loginTimedate = lastLoginTime.dateValue()
                    
                    let timestamp = data["timestamp"] as? Timestamp ?? Timestamp()
                    let timestampDate = timestamp.dateValue()
                    
                    await setUser(id,
                                  email: email,
                                  questionNum: questionNum,
                                  createdAt: loginTimedate,
                                  lastloginTime: timestampDate)
                }
                
            } catch {
                print("Read user error in firestore \(error.localizedDescription)")
            }
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
                if let currentUser = user {
                    Task {
                        let querySnapshot = try await databaseReference?.document(currentUser.user.uid).getDocument()
                        guard let querySnapshot else {
                            return
                        }
                        
                        if querySnapshot.exists {
                            return
                        }
                        await setUser(currentUser.user.uid,
                                      email: currentUser.user.email ?? "",
                                      questionNum: "1",
                                      createdAt: currentUser.user.metadata.creationDate ?? Date(),
                                      lastloginTime: Date())
                        await addUsers()
                        return
                    }
                }
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
