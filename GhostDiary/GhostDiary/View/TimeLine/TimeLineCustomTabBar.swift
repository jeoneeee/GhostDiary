//
//  TimeLineCustomTabBar.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/31.
//

import SwiftUI

struct TimeLineCustomTabBar: View {
    @Binding var selection: Int
    
    var body: some View {
        HStack {
            Button(action: {
                selection = 1
            }, label: {
                Image(systemName: "calendar")
            })
            Button(action: {
                selection = 2
            }, label: {
                Image(systemName: "list.bullet")
            })
        }
        .foregroundColor(.secondary)
    }
}

struct TimeLineCustomTabBar_Previews: PreviewProvider {
    @State static var tabSelection: Int = 0
    static var previews: some View {
        TimeLineCustomTabBar(selection: $tabSelection)
    }
}
