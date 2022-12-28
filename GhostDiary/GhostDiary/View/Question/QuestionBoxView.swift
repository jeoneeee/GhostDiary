//
//  QuestionBoxView.swift
//  GhostDiary
//
//  Created by 이지연 on 2022/12/18.
//

import SwiftUI

struct QuestionBoxView: View {
    @StateObject var questionStore: QuestionStore = QuestionStore()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(questionStore.questions) { idx in
                Text("Q. \(idx.id)")
                    .bold()
                    .font(.title3)
                    .foregroundColor(.black)
                Text(idx.query)
                    .font(.title3)
                    .foregroundColor(.black)
            }
        }
        .onAppear {
            questionStore.fetchQuestions()
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("Color1"))
                .frame(width: 320, height: 130)
        }
    }
}

struct QuestionBoxView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionBoxView()
    }
}
