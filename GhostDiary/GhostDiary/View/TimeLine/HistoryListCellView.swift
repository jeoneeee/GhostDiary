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
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("#\(question.number)")
                    .foregroundColor(Color("Color7"))
                Text(question.query)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(colorScheme == .dark ? Color(.white) : Color(.black))
                    .padding([.leading], 8)
                Spacer()
            }
            .modifier(BodyTextModifier())
        }
        .frame(width:UIScreen.screenWidth*0.9, alignment: .leading)
    }
}

struct HistoryListCellView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryListCellView(question: Question(id: "", number: 1, query: "당신이 가장 좋아하는 음식은 무엇인가요"),
                            answer: Answer(id: "", uid: "", expression: "", content: "", timestamp: Date()))
    }
}
