//
//  TimeLineView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/31.
//

import SwiftUI

struct TimeLineView: View {
    @EnvironmentObject var answersStores: AnswerStore
    @State private var category: TimeLineCategory = .calendar
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .trailing) {
                if answersStores.answers.count > 0 {
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
        }
    }
}

struct TimeLineView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineView()
            .environmentObject(AnswerStore())
    }
}
