//
//  TimeLineEmptyView.swift
//  GhostDiary
//
//  Created by 이학진 on 2023/01/26.
//

import SwiftUI

struct TimeLineEmptyView: View {
    
    var body: some View {
        VStack {
            Text("아직 작성된 답변이 없어요. 질문에 대답하여 자신을 기억하세요.")
                .modifier(TitleTextModifier())
        }
        .padding()
    }
    
}

struct TimeLineEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineEmptyView()
    }
}
