//
//  TimeLineCustomTabBar.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/31.
//

import SwiftUI

struct TimeLineCustomTabBar: View {
    @Binding var selection: TimeLineCategory
    
    var body: some View {
        HStack {
            Button(action: {
                selection = .calendar
            }, label: {
                VStack(alignment: .center, spacing: 0) {
                    Image(systemName: "calendar")
                        .foregroundColor(selection == .calendar ? .black : .secondary)
                        .fontWeight(selection == .calendar ? .bold : .regular)
                }
            })
            
            Button(action: {
                selection = .list
            }, label: {
                VStack(alignment: .center, spacing: 0) {
                    Image(systemName: "list.bullet")
                        .foregroundColor(selection == .list ? .black : .secondary)
                        .fontWeight(selection == .list ? .bold : .regular)
                }
            })
        }
        .foregroundColor(.secondary)
    }
}

struct TimeLineCustomTabBar_Previews: PreviewProvider {
    @State static var tabSelection: TimeLineCategory = .calendar
    
    static var previews: some View {
        TimeLineCustomTabBar(selection: $tabSelection)
    }
}
