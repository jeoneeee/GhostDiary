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
                
                TabView(selection: $tabSelection) {
                    CalendarView()
                        .tag(1)
                    HistoryListView()
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
    }
}

struct TimeLineView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineView()
    }
}
