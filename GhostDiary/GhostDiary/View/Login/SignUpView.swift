//
//  SingUpView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authStores: AuthStore
    
    @Binding var isSignUp: Bool
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var checkPassword: String = ""
    
    @State private var isValidatedEmail: Bool = false
    @State private var isDuplicatedEmail: DuplicatedEmail = .notdupleciated
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
    
    var isEmailExsit: Bool {
        switch isDuplicatedEmail {
        case .duplicated:
            return true
        case .notdupleciated:
            return false
        }
    }
    
    var body: some View {
        //FIXME: - 비밀번호 텍스트필드 SecureField로 수정 필요
        NavigationStack {
            VStack(alignment: .leading) {
                //Spacer()
                VStack(alignment: .leading) {
                    Text("이메일")
                        .font(.title3)
                        .padding([.leading])
                    HStack {
                        TextField("example@naver.com ", text: $email)
                            .modifier(LoginTextFieldModifier())
                            .onChange(of: email) { email in
                                isValidatedEmail = AuthCheck.validateEmail(email: email) ? true : false
                            }
                        Button(action: {
                            Task {
                                isDuplicatedEmail = await authStores.checkduplicationEmail(email: email)
                                // await authStores.checkduplicationEmail(email: email)
                            }
                        }, label: {
                            Text("중복 확인")
                                .padding(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .stroke(Color(UIColor.systemGray4), lineWidth: 2)
                                }
                                .foregroundColor(.secondary)
                        })
                    }
                    HStack {
                        ZStack {
                            
                            Text("올바른 형식의 이메일 입니다")
                                .offset(x: -15)
                                .modifier(ValidateText(color: .green))
                                .opacity(isValidatedEmail ? 1 : 0)
                            Text("올바르지 않은 형식의 이메일 입니다.")
                                .modifier(ValidateText(color: .red))
                                .opacity((!email.isEmpty && !isValidatedEmail) ? 1 : 0)
                        }
                        
                        Text("이미 가입된 이메일 입니다")
                            .modifier(ValidateText(color: .red))
                            .opacity(isEmailExsit ? 1 : 0)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("비밀번호")
                        .font(.title3)
                        .padding([.leading, .top])
                    
                    TextField("비밀번호를 입력하세요. ", text: $password)
                        .modifier(LoginTextFieldModifier())
                        .onChange(of: password) { password in
                            isValidatedPassword = AuthCheck.validatePassword(password: password) ? true : false
                        }
                        .disabled(isEmailExsit)
                    ZStack(alignment: .leading) {
                        Text("영문자,숫자,특수문자 8~20자리를 조합해 주세요.")
                            .modifier(ValidateText(color: .red))
                            .opacity((!password.isEmpty && !isValidatedPassword) ? 1 : 0)
                        Text("올바른 형식의 비밀번호 입니다")
                            .modifier(ValidateText(color: .green))
                            .opacity(isValidatedPassword ? 1 : 0)
                    }
                }
                //.frame(maxHeight: 100)
                .opacity(isEmailExsit ? 0.5 : 1)
                
                VStack(alignment: .leading) {
                    Text("비밀번호 확인")
                        .font(.title3)
                        .padding([.leading, .top])
                    TextField("비밀번호를 한번 더 입력하세요. ", text: $checkPassword)
                        .modifier(LoginTextFieldModifier())
                        .onChange(of: checkPassword) { checkPassword in
                            isEqulPassword = (password == checkPassword) ? true : false
                        }
                        .disabled(isEmailExsit)
                }
                .opacity(isEmailExsit ? 0.5 : 1)
                
                if isEqulPassword && !checkPassword.isEmpty{
                    Text("비밀번호가 일치합니다.")
                        .modifier(ValidateText(color: .green))
                } else if !checkPassword.isEmpty {
                    Text("비밀번호가 일치하지 않습니다.")
                        .modifier(ValidateText(color: .red))
                }
                
                Spacer()
                
                Button(action: {
                    Task {
                        guard await authStores.register(email: email, password: password) else {
                            return
                        }
                    }
                },label: {
                    Text("등록 완료")
                        .padding()
                })
                .modifier(LoginButton())
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
            .textInputAutocapitalization(.never)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 2)
            }
            .padding([.leading,.trailing])
    }
}

struct ValidateText: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(.caption)
            .padding([.leading])
    }
}

struct SignUpView_Previews: PreviewProvider {
    @State static var isSignUp: Bool = false
    static var previews: some View {
        SignUpView(isSignUp: $isSignUp)
            .environmentObject(AuthStore())
    }
}
