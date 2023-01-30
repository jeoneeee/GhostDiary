//
//  TimeLineView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/31.
//

import SwiftUI

struct TimeLineView: View {
    @EnvironmentObject var answerStores: AnswerStore
    @EnvironmentObject var authStores: AuthStore
    
    @State private var category: TimeLineCategory = .calendar
    @Binding var isLogin: Bool
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .trailing) {
                if answerStores.answers.count > 0 {
                    Spacer()
                    TimeLineCustomTabBar(selection: $category)
                        .padding()
                    
                    switch category {
                    case .calendar:
                        CalendarView()
                    case .list:
                        HistoryListView()
                    }
                } else {
                    TimeLineEmptyView()
                }
            }
            .navigationTitle("Ghost Diary")
            .navigationBarTitleDisplayMode(.inline)
            
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

struct TimeLineView_Previews: PreviewProvider {
    @State static private var isLogin: Bool = false
    
    static var previews: some View {
        TimeLineView(isLogin: $isLogin)
            .environmentObject(AnswerStore())
    }
}
