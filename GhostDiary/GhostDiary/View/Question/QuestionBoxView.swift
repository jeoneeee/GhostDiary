//
//  QuestionBoxView.swift
//  GhostDiary
//
//  Created by 이지연 on 2022/12/18.
//

import SwiftUI

struct QuestionBoxView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Q.123")
                .bold()
                .font(.title3)
            Text("내가 소중하게 생각하는 것 1가지")
                .font(.title2)
        }
        .padding(25)
        .background(Color("Color1"))
        .cornerRadius(10)
    }
}

struct QuestionBoxView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionBoxView()
    }
}
