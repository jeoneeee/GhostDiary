//
//  AnswerDetailView.swift
//  GhostDiary
//
//  Created by 이지연 on 2023/01/13.
//

import SwiftUI

struct AnswerDetailView: View {
    var body: some View {
        VStack {
            HStack {
                Text("2023-01-13")
                    .modifier(BodyTextModifier())
                    .foregroundColor(.gray)
                Image("cute")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 34, height: 34)
                    .shadow(radius: 2)
                    .padding(.leading, 10)
            }
            
            .padding(.bottom, 20)
            .padding(.top, 40)
            Text("금요일 저녁에는 어떤것을 하시나요?")
                .modifier(TitleTextModifier())
            
            Rectangle()
                .foregroundColor(.gray)
                .frame(height: 1)
                .padding(.horizontal, 20)
            
            Text("저는 금요일에 마라탕을 먹고 침대에 누워있는 \n삶을 살고싶어요. \n그리고는 침대에 누워서 밀린 유튜브를 하나씩..")
                .modifier(BodyTextModifier())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 25)
            
            Spacer()
            
            


            
        }
    }
}

struct AnswerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerDetailView()
    }
}
