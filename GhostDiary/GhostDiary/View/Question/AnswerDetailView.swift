//
//  AnswerDetailView.swift
//  GhostDiary
//
//  Created by 이지연 on 2023/01/13.
//

import SwiftUI

struct AnswerDetailView: View {
    let question: Question
    let answer: Answer
    
    var body: some View {
        VStack {
            HStack {
                Text(answer.timestamp.getDay())
                    .modifier(BodyTextModifier())
                    .foregroundColor(.gray)
                
                Image(answer.expression)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 34, height: 34)
                    .shadow(radius: 2)
                    .padding(.leading, 10)
            }
            
            .padding(.bottom, 20)
            .padding(.top, 40)
            
            Text(question.query)
                .modifier(TitleTextModifier())
            
            Rectangle()
                .foregroundColor(.gray)
                .frame(height: 1)
                .padding(.horizontal, 20)
            
            Text(answer.content)
                .modifier(BodyTextModifier())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 25)
            
            Spacer()
        }
    }
}

struct AnswerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerDetailView(question: Question(id: "", number: 1, query: ""),
                         answer: Answer(id: "", uid: "", expression: "", content: "", timestamp: Date()))
    }
}
