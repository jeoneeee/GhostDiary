//
//  LoginView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

struct LoginView: View {
    @StateObject var authStores = AuthStore()
    
    @State var email: String = ""
    @State var password: String = ""
    @State var isSingUp: Bool = false
    
    @State var isPasswordHidden: Bool = false
    @State var isSuccesLogin: Bool = false
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
                    let loginCode = await authStores.signIn(email: email, password: password)
                    if loginCode == .success {
                        isSuccesLogin.toggle()
                    }
                    loginMessage = getErrorMessage(loginCode: loginCode)
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
        }
        .padding()
        
        .fullScreenCover(isPresented: $isSingUp) {
            SignUpView(isSignUp: $isSingUp)
                .environmentObject(authStores)
        }
        .fullScreenCover(isPresented: $isSuccesLogin) {
            HomeView()
        }
        
        .onAppear {
            authStores.startListeners()
        }
        .onDisappear {
            authStores.disConnectListeners()
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

struct LoginButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: UIScreen.main.bounds.width)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(40)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
