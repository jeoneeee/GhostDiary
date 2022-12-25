//
//  ContentView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authStores = AuthStore()
    @State private var isLogin: Bool = false
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                if isLogin || authStores.loginStatus == .logined {
                    HomeView(isLogin: $isLogin)
                        .environmentObject(authStores)
                } else {
                    LoginView(isLogin: $isLogin, isLoading: $isLoading)
                        .environmentObject(authStores)
                }
            }
            if isLoading {
                LoadingView()
            }
        }
        .onAppear {
            print("authStores.loginStatus: \(authStores.loginStatus)")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
