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
    
    @State private var isValidatedEmail: Bool = false
    @State private var isValidatedPassword: Bool = false
    @State private var isEqulPassword: Bool = false
    
    var disableRegister: Bool {
        if isValidatedEmail == true,
           isValidatedEmail == isValidatedPassword,
           isValidatedEmail == isEqulPassword {
            return false
        }
        return true
    }
    
    
    var body: some View {
        //FIXME: - 비밀번호 텍스트필드 SecureField로 수정 필요
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    TextField("이메일을 입력하세요. ", text: $email)
                        .modifier(LoginTextFieldModifier())
                        .onChange(of: email) { email in
                            isValidatedEmail = AuthCheck.validateEmail(email: email) ? true : false
                        }
                    
                    
                    if isValidatedEmail {
                        Text("올바른 형식의 이메일 입니다")
                            .modifier(ValidateText())
                    } else if !email.isEmpty {
                        Text("올바르지 않은 형식의 비밀번호 입니다.")
                            .modifier(NotValidateText())
                    }
                }
                //.frame(maxHeight: 100)
                
                VStack(alignment: .leading) {
                    TextField("비밀번호를 입력하세요. ", text: $password)
                        .modifier(LoginTextFieldModifier())
                        .onChange(of: password) { password in
                            isValidatedPassword = AuthCheck.validatePassword(password: password) ? true : false
                        }
                    if isValidatedPassword {
                        Text("올바른 형식의 비밀번호 입니다.")
                            .modifier(ValidateText())
                    } else if !password.isEmpty {
                        Text("올바르지 않은 형식의 비밀번호 입니다.")
                            .modifier(NotValidateText())
                    }
                }
                .frame(maxHeight: 100)
                
                VStack(alignment: .leading) {
                    TextField("비밀번호를 한번 더 입력하세요. ", text: $checkPassword)
                        .modifier(LoginTextFieldModifier())
                        .onChange(of: checkPassword) { checkPassword in
                            isEqulPassword = (password == checkPassword) ? true : false
                        }
                }
                if isEqulPassword {
                    Text("비밀번호가 일치합니다.")
                        .modifier(ValidateText())
                } else if !checkPassword.isEmpty {
                    Text("비밀번호가 일치하지 않습니다.")
                        .modifier(NotValidateText())
                }
                    
                Spacer()
                
                Button(action: {
                    //                        guard viewModel.validate() else { return }
                    //                        viewModel.login()
                },label: {
                    Text("등록 완료")
                        .padding()
                })
                .frame(maxWidth: UIScreen.main.bounds.width)
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(40)
                .disabled(disableRegister)
                .opacity(disableRegister ? 0.5 : 1)
            }
            .padding()
            .textInputAutocapitalization(.never)
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
            .padding([.leading,.trailing])
    }
}

struct NotValidateText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.red)
            .font(.caption)
            .padding([.leading], 20)
    }
}

struct ValidateText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.green)
            .font(.caption)
            .padding([.leading], 20)
    }
}

struct SignUpView_Previews: PreviewProvider {
    @State static var isSignUp: Bool = false
    static var previews: some View {
        SignUpView(isSignUp: $isSignUp)
    }
}
