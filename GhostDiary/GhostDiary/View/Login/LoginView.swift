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
    
    var body: some View {
        VStack {
            TextField("이메일을 입력하세요. ", text: $email)
                .textContentType(.emailAddress)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(Color(UIColor.systemGray4), lineWidth: 2)
                }
                .padding()
            //FIXME: - TextField -> SecureField로 수정 예정
            TextField("비밀번호를 입력하세요. ", text: $password)
                .textContentType(.password)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(Color(UIColor.systemGray4), lineWidth: 2)
                }
                .padding()
            
            Button(action: {
                
            }, label: {
                Text("로그인")
                    .padding()
            })
            .frame(maxWidth: UIScreen.main.bounds.width)
            .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(40)
            
            //FIXME: - Color 수정 예정
            Button(action: {
                isSingUp.toggle()
            }, label: {
                Text("회원가입")
                    .padding()
            })
            .frame(maxWidth: UIScreen.main.bounds.width)
            .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(40)
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
