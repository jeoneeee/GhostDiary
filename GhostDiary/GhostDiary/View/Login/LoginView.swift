//
//  LoginView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var authStores: AuthStore
    
    @Environment(\.window) var window: UIWindow?
    @State private var appleLoginCoordinator: AppleAuthCoordinator?
    
    @Binding var isLogin: Bool
    @Binding var isLoading: Bool
    
    @State var email: String = ""
    @State var password: String = ""
    @State var isSingUp: Bool = false
    
    @State var isPasswordHidden: Bool = false
    @State var loginMessage: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Image(systemName: "person.fill")
                    .foregroundColor(.secondary)
                
                TextField(text: $email) {
                    Label("이메일", systemImage: "lock.fill")
                }
            }
            .modifier(LoginTextFieldModifier())
            .padding(.bottom)
            
            HStack {
                ZStack {
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.secondary)
                        if isPasswordHidden {
                            TextField("비밀번호", text: $password)
                        } else {
                            SecureField("비밀번호", text: $password)
                        }
                    }
                    .modifier(LoginTextFieldModifier())
                }
                .overlay(alignment: .topTrailing) {
                    Button(action: {
                        isPasswordHidden.toggle()
                    }, label: {
                        Image(systemName: isPasswordHidden ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(.secondary)
                    })
                    .offset(x: -20, y: 20)
                }
            }
            
            Text(loginMessage)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Button(action: {
                Task {
                    isLoading.toggle()
                    let loginCode = await authStores.signIn(email: email, password: password)
                    if loginCode == .success {
                        isLogin.toggle()
                    }
                    isLoading.toggle()
                    loginMessage = authStores.getErrorMessage(loginCode: loginCode)
                }
            }, label: {
                Text("로그인")
                    .padding()
            })
            .modifier(LoginButton())
            
            Button(action: {
                isSingUp.toggle()
            }, label: {
                Text("회원가입")
                    .padding()
            })
            .modifier(LoginButton())
            
            Spacer()
            
            Button {
                handleSignInButton()
            } label: {
                HStack {
                    Spacer()
                    Image("googleButton")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                    Text("Google로 계속하기")
                        .foregroundColor(.black)
                        .bold()
                    Spacer()
                }
                .frame(width: UIScreen.screenWidth - 100, height: 44)
                .background(.white)
                .overlay {
                    Capsule()
                        .stroke(Color.gray, lineWidth: 1)
                }
            }
            
            // FIXME: - Custom Apple Login Button 작업 필요
            Button {
                appleLogin()
            } label: {
                Text("애플로 로그인")
            }
        }
        .padding()
        
        .fullScreenCover(isPresented: $isSingUp) {
            SignUpView(isSignUp: $isSingUp)
                .environmentObject(authStores)
        }
        
        .onAppear {
            authStores.startListeners()
        }
        .onDisappear {
            authStores.disConnectListeners()
        }
    }
    
    func handleSignInButton() {
        authStores.googleSignIn()
    }
    
    func appleLogin() {
        appleLoginCoordinator = AppleAuthCoordinator(window: window)
        appleLoginCoordinator?.startAppleLogin()
    }
}

struct LoginButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: UIScreen.main.bounds.width)
            .foregroundColor(.white)
            .background(Color("Color3"))
            .cornerRadius(40)
    }
}

//TODO: - LoadingView 파일 위치 이동
struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color("Color1")))
                .scaleEffect(3)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var isLogin: Bool = false
    @State static var isLoading: Bool = false
    static var previews: some View {
        LoginView(isLogin: $isLogin, isLoading: $isLoading)
            .environmentObject(AuthStore())
    }
}
