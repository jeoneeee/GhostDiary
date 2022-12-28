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

enum LoginStatus {
    case notRegistered
    case notLogin
    case logined
}

class AuthStore: ObservableObject {
    
    var handel: AuthStateDidChangeListenerHandle?
    var user: FirebaseAuth.User?
    var loginStatus: LoginStatus = .notRegistered // default
    
    private lazy var databaseReference: CollectionReference? = {
        let reference = Firestore.firestore().collection("users")
        return reference
    }()
    
    // MARK: - 로그인 관련 상태를 관리하는 메소드
    /// 이전에 로그인을 했다면 클로저의 user 매개변수에 마지막에 로그인했던 유저의 정보가 담겨져있음
    func startListeners() {
        self.handel = Auth.auth().addStateDidChangeListener { auth, user in
            if let user {
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
            loginStatus = .notLogin
            print("회원가입 성공")
            await addUsers(email: email, password: password, createdAt: TimeData.getTimeStrings())
            print("DB에 추가 성공")
            return true
        } catch {
            print("User Register Error: \(error)")
            return false
        }
    }
    
    func signIn(email: String, password: String) async {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            print("로그인 성공")
            print("로그인한 유저 이메일: \(String(describing: self.user?.email)), uid: \(String(describing: self.user?.uid))")
            loginStatus = .logined
        }
        catch {
            print("Sign In Error : \(error)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
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
