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
 
    var body: some View {
        NavigationStack {
            VStack {
                Image("\(todayEmoji)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .padding(.vertical, 20)
                    .shadow(radius: 2)
                
                ZStack {
                    if text.isEmpty {
                        TextEditor(text: .constant("내용을 입력해주세요"))
                            .foregroundColor(.secondary)
                            .disabled(true)
                    }
                    TextEditor(text: $text)
                        .focused($isInFocusText)
                        .opacity(text.isEmpty ? 0.25 : 1)
                }
                .padding([.leading, .trailing])
                
                Button {
                    
                } label: {
                    Text("확인")
                        .font(.title3)
                        .padding(.vertical, 18)
                        .padding(.horizontal, 100)
                        .background(Color("Color5"))
                        .cornerRadius(20)
                        .foregroundColor(.black)
                }
                .padding(.vertical, 30)

                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
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
