//
//  QuestionBoxView.swift
//  GhostDiary
//
//  Created by 이지연 on 2022/12/18.
//

import SwiftUI

struct QuestionBoxView: View {
    @EnvironmentObject var questionStore: QuestionStore
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Q. \(questionStore.questions.number)")
                .bold()
            Text(questionStore.questions.query)
        }
        .modifier(TitleTextModifier())
        .foregroundColor(colorScheme == .dark ? Color(.white) : Color(.black))
        .padding(.leading, 20)
        .frame(width: 320, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(colorScheme == .dark ? Color("Color10") : Color("Color1"))
                .frame(width: 320, height: 130)
        }
    }
}

struct QuestionBoxView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionBoxView()
            .environmentObject(QuestionStore())
    }
}
