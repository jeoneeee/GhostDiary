//
//  HistoryListCellView.swift
//  GhostDiary
//
//  Created by 이학진 on 2023/01/17.
//

import SwiftUI

struct HistoryListCellView: View {
    let question: Question
    let answer: Answer
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("#\(question.number)")
                    .foregroundColor(Color("Color7"))
                    .frame(width: 20, alignment: .leading)
                Text(question.query)
                    .foregroundColor(Color("Color5"))
                
                Spacer()
            }
            .modifier(BodyTextModifier())
        }
    }
}

struct HistoryListCellView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryListCellView(question: Question(id: "", number: "1", query: "당신이 가장 좋아하는 음식은 무엇인가요"),
                            answer: Answer(id: "", uid: "", expression: "", content: "", timestamp: Date()))
    }
}
