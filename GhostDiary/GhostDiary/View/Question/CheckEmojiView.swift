//
//  CheckEmoji.swift
//  GhostDiary
//
//  Created by 이지연 on 2022/12/25.
//

import SwiftUI

struct CheckEmojiView: View {
    @State var todayEmoji: String = ""
    @Binding var isShowingEmojiSheet: Bool
    @Binding var isShowingQuestionSheet: Bool
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("먼저 오늘의 기분을 선택해주세요!")
                .font(.title3)
                .padding(.bottom)
            HStack(spacing: 20) {
                Button {
                    todayEmoji = "angry"
                } label: {
                    Image("angry")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
                Button {
                    todayEmoji = "cute"
                } label: {
                    Image("cute")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
                Button {
                    todayEmoji = "proud"
                } label: {
                    Image("proud")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
            }
            HStack(spacing: 20) {
                Button {
                    todayEmoji = "sad"
                } label: {
                    Image("sad")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
                Button {
                    todayEmoji = "tired"
                } label: {
                    Image("tired")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
                Button {
                    todayEmoji = "umm"
                } label: {
                    Image("umm")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
            }
            
            Button {
                isShowingEmojiSheet.toggle()
                isShowingQuestionSheet.toggle()
            } label: {
                Text("확인")
            }

        }

    }
}

//struct CheckEmoji_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckEmojiView()
//    }
//}
