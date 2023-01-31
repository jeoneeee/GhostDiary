//
//  SingUpView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authStores: AuthStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var checkPassword: String = ""
    
    @State private var isValidatedEmail: Bool = false
    @State private var isDuplicatedEmail: DuplicatedEmail = .duplicated
    @State private var isValidatedPassword: Bool = false
    @State private var isEqulPassword: Bool = false
    
    @State private var isPressEmailButton: Bool = false
    
    var disableRegister: Bool {
        if isValidatedEmail == true,
           isValidatedEmail == isValidatedPassword,
           isValidatedEmail == isEqulPassword {
            return false
        }
        return true
    }
    
    /// 현재 텍스트필드에 입력된 이메일이 가입되어 있는지 확인하는 연산 프로퍼티
    /// true값을 반환하면 이메일이 중복되었다는 뜻이며, false는 중복되지 않았다는 뜻이다.
    var isEmailExsit: Bool {
        switch isDuplicatedEmail {
        case .duplicated:
            return true
        case .notduplicated:
            return false
        }
    }
    
    private var emailView: some View {
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
                    isPressEmailButton = true
                    Task {
                        isDuplicatedEmail = await authStores.checkduplicationEmail(email: email)
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
                
                Spacer()
                
                Text("이미 가입된 이메일 입니다")
                    .modifier(ValidateText(color: .red))
                    .opacity(isEmailExsit && isPressEmailButton ? 1 : 0)
            }
        }
    }
    
    private var passwordView: some View {
        VStack(alignment: .leading) {
            Text("비밀번호")
                .font(.title3)
                .padding([.leading, .top])
            
            SecureField("비밀번호를 입력하세요. ", text: $password)
                .modifier(LoginTextFieldModifier())
                .onChange(of: password) { password in
                    isValidatedPassword = AuthCheck.validatePassword(password: password) ? true : false
                }
            ZStack(alignment: .leading) {
                Text("영문자,숫자,특수문자 8~20자리를 조합해 주세요.")
                    .modifier(ValidateText(color: .red))
                    .opacity((!password.isEmpty && !isValidatedPassword) ? 1 : 0)
                Text("올바른 형식의 비밀번호 입니다")
                    .modifier(ValidateText(color: .green))
                    .opacity(isValidatedPassword ? 1 : 0)
            }
        }
        .opacity(isEmailExsit ? 0.5 : 1)
    }
    
    private var psswordCheckView: some View {
        VStack(alignment: .leading) {
            Text("비밀번호 확인")
                .font(.title3)
                .padding([.leading, .top])
            SecureField("비밀번호를 한번 더 입력하세요. ", text: $checkPassword)
                .modifier(LoginTextFieldModifier())
                .onChange(of: checkPassword) { checkPassword in
                    isEqulPassword = (password == checkPassword) ? true : false
                }
            
            if isEqulPassword && !checkPassword.isEmpty{
                Text("비밀번호가 일치합니다.")
                    .modifier(ValidateText(color: .green))
            } else if !checkPassword.isEmpty {
                Text("비밀번호가 일치하지 않습니다.")
                    .modifier(ValidateText(color: .red))
            }
        }
        .opacity(isEmailExsit ? 0.5 : 1)
    }
    
    var body: some View {
        //FIXME: - 비밀번호 텍스트필드 SecureField로 수정 필요
        VStack(alignment: .leading) {
            emailView
            
            if !isEmailExsit {
                passwordView
                psswordCheckView
            }
            
            Spacer()
            
            Button(action: {
                Task {
                    guard await authStores.register(email: email, password: password) else {
                        return
                    }
                }
            },label: {
                Text("회원가입 완료")
                    .padding()
            })
            .modifier(disableRegister ? LoginButton(backgroudColor: Color(.systemGray3)) : LoginButton(backgroudColor: Color("Color5")))
            .disabled(disableRegister)
        }
        .padding()
        .textInputAutocapitalization(.never)
        .formStyle(.automatic)
        
        .navigationTitle("회원가입")
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

struct SignUpView_Previews: PreviewProvider {
    @State static var isSignUp: Bool = false
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthStore())
    }
}
