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
    
    var body: some View {
        VStack {
            Spacer()
            TextField("이메일을 입력하세요. ", text: $email)
                .modifier(LoginTextFieldModifier())
                .padding([.bottom])
            
            HStack {
                ZStack {
                    if isPasswordHidden {
                        //FIXME: - TextField -> SecureField로 수정 예정
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
            
            Spacer()
            Button(action: {
                
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
        .onAppear {
            authStores.startListeners()
        }
        .onDisappear {
            authStores.disConnectListeners()
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
