//
//  QuestionView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

struct QuestionView: View {
    @State var isShowingEmojiSheet: Bool = false
    @State var isShowingQuestionSheet: Bool = false
    @State var todayEmoji: String = ""
    @State var showDetailView = false
    
    @EnvironmentObject var questionStore: QuestionStore
    @EnvironmentObject var authStore: AuthStore
    @EnvironmentObject var answerStores: AnswerStore
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                GhostImageView()
                Spacer()
                
                Button {
                    var _ = print("1번 = \(showDetailView)")
                    Task {
                        if await questionStore.isCheckingAnswer(user: authStore.user!) {
                            showDetailView.toggle()
                        } else {
                            isShowingEmojiSheet.toggle()
                        }
                    }//Task
                } label: {
                    QuestionBoxView()
                }
                .navigationDestination(isPresented: $showDetailView) {
                    if let index = answerStores.questions.firstIndex{$0.id == questionStore.questions.id} {
                        if answerStores.questions.count == answerStores.answers.count { // 질문을 가져온 후 대답을 가져오는데 그 도중에 화면이 생겨서 에러가 생김..그렇기때문에 if문으로 설정
                            AnswerDetailView(question: answerStores.questions[index], answer: answerStores.answers[index])
                        }
                    }
                }
                
            }
            .padding([.bottom], 60)
            
            .sheet(isPresented: $isShowingEmojiSheet) {
                CheckEmojiView(todayEmoji: $todayEmoji, isShowingEmojiSheet: $isShowingEmojiSheet, isShowingQuestionSheet: $isShowingQuestionSheet)
                    .onDisappear {
                        if isShowingEmojiSheet == false {
                            isShowingQuestionSheet = true
                        }
                    } // 실행하고나서 이 코드를 실행해라!, 화면이 닫힐 때
                    .presentationDetents([.fraction(0.54)])
            } // 이모지 선택
            .fullScreenCover(isPresented: $isShowingQuestionSheet) {
                AnswerView(todayEmoji: $todayEmoji, question: questionStore.questions)
            }
            
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
