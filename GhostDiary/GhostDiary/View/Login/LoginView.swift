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
    @Environment(\.colorScheme) var colorScheme
    
    @Environment(\.window) var window: UIWindow?
    @State private var appleLoginCoordinator: AppleAuthCoordinator?
    
    @Binding var isLogin: Bool
    @Binding var isLoading: Bool
    @State private var isSingUp: Bool = false
    @State private var isEmailLogin: Bool = false
    
    var socialLoginButton: some View {
        VStack {
            Button {
                handleSignInButton()
            } label: {
                HStack {
                    Spacer()
                    Image("googleButton")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                    Text("Google로 계속하기")
                        //.modifier(CaptionTextModifier())
                        .foregroundColor(.black)
                        .bold()
                    Spacer()
                }
                .frame(width: UIScreen.screenWidth - 75, height: 44)
                .border(.gray)
            }
            .background(.white)

            
            Button {
                appleLogin()
            } label: {
                HStack(alignment: .center) {
                    Spacer()
                    Image("appleLoginButton")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 50, height: 44)
                    Text("Apple로 계속하기")
                        //.modifier(CaptionTextModifier())
                        .foregroundColor(.black)
                        .bold()
                    Spacer()
                }
                .frame(width: UIScreen.screenWidth - 75, height: 44)
                .border(.gray)
            }
            .background(.white)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("Ghost Diary")
                    .font(.custom("나눔손글씨 느릿느릿체", size: 60))
                    .foregroundColor(Color("Color4"))
                    .bold()
                Text("나를 찾아주는 100개의 질문에 답을 해보세요.")
                    .modifier(BodyTextModifier())
                    .padding()
                
                Spacer()
                
                socialLoginButton
                
                Rectangle()
                    .foregroundColor(colorScheme == .dark ? Color(.white) : Color(uiColor: UIColor.systemGray5))
                    .frame(height: 1)
                    .padding(20)
                
                HStack {
                    Spacer()
                    NavigationLink(destination: EmailLoginView(isLogin: $isLogin, isLoading: $isLoading)) {
                        Text("이메일로 로그인")
                            .modifier(CaptionTextModifier())
                    }
                    Spacer()
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("이메일로 회원가입")
                            .modifier(CaptionTextModifier())
                    }
                    Spacer()
                }
                .foregroundColor(.secondary)
                
                Spacer()
            }
        }
        
        .navigationDestination(isPresented: $isEmailLogin) {
            EmailLoginView(isLogin: $isLogin, isLoading: $isLoading)
        }
        .navigationDestination(isPresented: $isSingUp) {
            SignUpView()
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

struct LoginView_Previews: PreviewProvider {
    @State static var isLogin: Bool = false
    @State static var isLoading: Bool = false
    static var previews: some View {
        LoginView(isLogin: $isLogin, isLoading: $isLoading)
            .environmentObject(AuthStore())
    }
}
