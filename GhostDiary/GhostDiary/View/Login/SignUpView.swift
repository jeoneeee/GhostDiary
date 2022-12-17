//
//  SingUpView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

struct SignUpView: View {
    @Binding var isSignUp: Bool
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var checkPassword: String = ""
    
    @State private  var isValidatedEmail: Bool = false
    @State private  var isValidatedPassword: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                TextField("이메일을 입력하세요. ", text: $email)
                    .modifier(LoginTextFieldModifier())
                
                TextField("비밀번호를 입력하세요. ", text: $password)
                TextField("비밀번호를 한번 더 입력하세요. ", text: $checkPassword)
                    .modifier(LoginTextFieldModifier())
                Button(action: {
                    //                        guard viewModel.validate() else { return }
                    //                        viewModel.login()
                },label: {
                    Text("가입")
                })
                .frame(maxWidth: UIScreen.main.bounds.width)
            }
            .formStyle(.automatic)
            
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        isSignUp.toggle()
                    }, label: {
                        Text("Cancel")
                    })
                }
            }
        }
    }
}

struct LoginTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 2)
            }
            .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    @State static var isSignUp: Bool = false
    static var previews: some View {
        SignUpView(isSignUp: $isSignUp)
    }
}
