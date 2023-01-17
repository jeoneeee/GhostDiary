//
//  CalendarView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

struct CalendarView: View {
    @State private var currentDate: Date = Date()
    @EnvironmentObject var authStores: AuthStore
    @EnvironmentObject var answerStores: AnswerStore
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            CustomDatePicker(currentDate: $currentDate)
        }
        .padding(.horizontal, 20)
        
        .onAppear {
            Task {
                if let user = authStores.user {
                    await answerStores.readAnswer(user)
                }
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(AuthStore())
            .environmentObject(AnswerStore())
    }
}
