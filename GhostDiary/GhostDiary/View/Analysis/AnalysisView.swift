//
//  AnalysisView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

struct AnalysisView: View {
    @State private var year = Int(Date().getYear())!
    @State private var month = Int(Date().getMonth())!
    
    @EnvironmentObject var answerStores: AnswerStore
    @EnvironmentObject var authStores: AuthStore
    @Binding var isLogin: Bool
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    
                    Button {
                        if month > 1 {
                            month -= 1
                        } else {
                            year -= 1
                            month = 12
                        }
                    } label: {
                        Image(systemName:"chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    
                    Text("\(String(year))년 \(month)월")
                        .modifier(TitleTextModifier())
                        .padding(.horizontal, 15)
                    if !(year == Int(Date().getYear())! && Int(Date().getMonth())! == month) {
                        Button {
                            if month < 12 {
                                month += 1
                            } else {
                                year += 1
                                month = 1
                            }
                        } label: {
                            Image(systemName:"chevron.right")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                    } else {
                        Button {
                            if month < 12 {
                                month += 1
                            } else {
                                year += 1
                                month = 1
                            }
                        } label: {
                            Image(systemName:"chevron.right")
                                .font(.title2)
                                .foregroundColor(Color("bgColor"))
                        }
                        .disabled(true)
                    }
                } // HStack
                .padding(.top, 30)
                Spacer()
                ChartView(year: $year, month: $month)
                    .frame(width: UIScreen.screenWidth * 0.85, height: UIScreen.screenHeight * 0.4)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("로그아웃") {
                            answerStores.questions.removeAll()
                            answerStores.answers.removeAll()

                            authStores.signOut()
                            isLogin = false
                            authStores.loginStatus = .defatult
                            authStores.googleSignOut()
                        }
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.body)
                    }
                }
            }
        }
    }
}

struct AnalysisView_Previews: PreviewProvider {
    @State static private var isLogin: Bool = false
    
    static var previews: some View {
        AnalysisView(isLogin: $isLogin)
            .environmentObject(AuthStore())
            .environmentObject(AnswerStore())
    }
}
