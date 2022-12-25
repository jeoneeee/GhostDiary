//
//  LoginView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct LoginView: View {
    @EnvironmentObject var authStores: AuthStore
    
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
            TextField("이메일을 입력하세요. ", text: $email)
                .modifier(LoginTextFieldModifier())
                .padding([.bottom])
            
            HStack {
                ZStack {
                    if isPasswordHidden {
                        TextField("비밀번호를 입력하세요. ", text: $password)
                            .modifier(LoginTextFieldModifier())
                            .padding([.bottom])
                    } else {
                        SecureField("비밀번호를 입력하세요. ", text: $password)
                            .modifier(LoginTextFieldModifier())
                            .padding([.bottom])
                    }
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
            
            //FIXME: - Color 수정 예정
            Button(action: {
                isSingUp.toggle()
            }, label: {
                Text("회원가입")
                    .padding()
            })
            .modifier(LoginButton())
            Spacer()
            
            GoogleSignInButton(action: handleSignInButton)
                .frame(width: 280, height: 60)
                //.modifier(LoginButton())
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
    }
}
