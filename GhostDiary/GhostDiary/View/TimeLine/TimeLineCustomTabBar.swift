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
                VStack(alignment: .center, spacing: 0) {
                    Image(systemName: "calendar")
                        .foregroundColor(selection == 1 ? .black : .secondary)
                        .fontWeight(selection == 1 ? .bold : .regular)
                }
            })
            
            Button(action: {
                selection = 2
            }, label: {
                VStack(alignment: .center, spacing: 0) {
                    Image(systemName: "list.bullet")
                        .foregroundColor(selection == 2 ? .black : .secondary)
                        .fontWeight(selection == 2 ? .bold : .regular)
                }
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
