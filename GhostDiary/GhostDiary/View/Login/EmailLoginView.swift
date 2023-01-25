//
//  EmailLoginView.swift
//  GhostDiary
//
//  Created by 이학진 on 2023/01/25.
//

import SwiftUI

// MARK: - Email로 로그인을 하는 뷰
struct EmailLoginView: View {
    @EnvironmentObject var authStores: AuthStore
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isLogin: Bool
    @Binding var isLoading: Bool
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var isPasswordHidden: Bool = false
    @State var loginMessage: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.fill")
                    .foregroundColor(.secondary)
                
                TextField(text: $email) {
                    Label("이메일", systemImage: "lock.fill")
                }
            }
            .modifier(LoginTextFieldModifier())
            .padding(.vertical)
            
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
            .padding(.bottom)
            
            Text(loginMessage)
                .foregroundColor(.secondary)
            
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
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("이메일로 로그인")
        .navigationBarBackButtonHidden(true)
        
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

//struct EmailLoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmailLoginView()
//    }
//}
