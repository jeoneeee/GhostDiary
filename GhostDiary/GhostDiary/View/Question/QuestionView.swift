//
//  QuestionView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

struct QuestionView: View {
    var body: some View {
        VStack {
            Spacer()
            GhostImageView()
            Spacer()
            QuestionBoxView()
        }
        .padding([.bottom], 20)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
