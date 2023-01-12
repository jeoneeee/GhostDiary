//
//  CheckEmoji.swift
//  GhostDiary
//
//  Created by 이지연 on 2022/12/25.
//

import SwiftUI

struct CheckEmojiView: View {
    @Binding var todayEmoji: String
    @Binding var isShowingEmojiSheet: Bool
    @Binding var isShowingQuestionSheet: Bool
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    let emojiarr = ["angry", "cute", "proud", "sad", "tired", "umm"]
    
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text("오늘은 어떤 하루였나요?")
                .font(.title2)
                .padding(.bottom)
            
            LazyVGrid(columns: columns){
                ForEach(emojiarr, id: \.self) { index in
                    Button {
                        todayEmoji = index
                    } label: {
                        
                        if index == todayEmoji{
                            Image("\(index)")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .shadow(radius: 5)
                        }else{
                            Image("\(index)")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .padding(15)
                        }
                        
                    }
                }
            }
            .padding(.horizontal, 20)
        }
            
        
        
        Button {
            isShowingEmojiSheet = false
        } label: {
            Text("확인")
                .font(.title3)
                .padding(.vertical, 13)
                .padding(.horizontal, 50)
                .background(Color("Color3"))
                .cornerRadius(15)
                .foregroundColor(.black)
        }
        .padding(.vertical, 30)
        
    }
    
    
    
}


struct CheckEmoji_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
