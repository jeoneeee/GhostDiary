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
        VStack {
            CustomDatePicker(currentDate: $currentDate)
            
            Spacer()
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
