//
//  TimeLineView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/31.
//

import SwiftUI

struct TimeLineView: View {
    @State private var tabSelection: Int = 1
    var body: some View {
        NavigationStack {
            VStack(alignment: .trailing) {
                Spacer()
                TimeLineCustomTabBar(selection: $tabSelection)
                    .padding()
                
                switch tabSelection {
                case 1:
                    CalendarView()
                case 2:
                    HistoryListView()
                default:
                    CalendarView()
                }
            }
        }
    }
}

struct TimeLineView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineView()
    }
}
