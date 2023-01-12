//
//  AnswerView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/25.
//

import SwiftUI

struct AnswerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var todayEmoji: String
    @State private var text: String = ""
    @FocusState private var isInFocusText: Bool
    @StateObject var questionStore: QuestionStore = QuestionStore()


 
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(questionStore.questions.createdDate)
                        .modifier(BodyTextModifier())
                        .foregroundColor(.gray)
                    Image("\(todayEmoji)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 70)
                        .shadow(radius: 2)
                        .padding(.leading, 10)
                }
                
                Text(questionStore.questions.query)
                    .modifier(TitleTextModifier())
                
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(height: 1)
                    .padding(.horizontal, 20)
                
                ZStack {
                    if text.isEmpty {
                        TextEditor(text: .constant("내용을 입력해주세요"))
                            .modifier(BodyTextModifier())
                            .foregroundColor(.secondary)
                            .disabled(true)
                    }
                    TextEditor(text: $text)
                        .modifier(BodyTextModifier())
                        .focused($isInFocusText)
                        .opacity(text.isEmpty ? 0.25 : 1)
                }
                .padding([.leading, .trailing])
                
                Button {
                    dismiss()
                } label: {
                    Text("확인")
                        .modifier(BodyTextModifier())
                        .padding(.vertical, 10)
                        .padding(.horizontal, 55)
                        .background(Color("Color5"))
                        .cornerRadius(17)
                        .foregroundColor(.black)
                }
                .padding(.vertical, 30)

                
            }
            .onAppear {
                questionStore.fetchQuestions()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                            .modifier(BodyTextModifier())
                    }
                }
            }
        }
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView(todayEmoji: .constant("umm"))
 
    }
}
