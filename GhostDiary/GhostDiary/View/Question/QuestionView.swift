//
//  QuestionView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

struct QuestionView: View {
    @State private var isShowingEmojiSheet: Bool = false
    @State private var isShowingQuestionSheet: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            GhostImageView()
            Spacer()
            
            Button {
                isShowingEmojiSheet.toggle()
            } label: {
                QuestionBoxView()
            }
            
        }
        .padding([.bottom], 60)
        .sheet(isPresented: $isShowingEmojiSheet) {
            CheckEmojiView(isShowingEmojiSheet: $isShowingEmojiSheet, isShowingQuestionSheet: $isShowingQuestionSheet)
                .presentationDetents([.fraction(0.4)])
        } // 이모지 선택
        .fullScreenCover(isPresented: $isShowingQuestionSheet) {
            AnswerView()
        } // 대답 입력
        .background {
            Image("b3")
                .opacity(0.6)
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
