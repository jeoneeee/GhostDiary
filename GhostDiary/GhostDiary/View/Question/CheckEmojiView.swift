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
                .modifier(TitleTextModifier())
                .padding(.vertical)
                .padding(.top, 20)
            
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
                .modifier(TitleTextModifier())
                .padding(.vertical, 10)
                .padding(.horizontal, 55)
                .background(Color("Color3"))
                .cornerRadius(17)
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
