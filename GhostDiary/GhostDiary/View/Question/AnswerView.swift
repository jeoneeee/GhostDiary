//
//  AnswerView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/25.
//

import SwiftUI

struct AnswerView: View {
    @Environment(\.dismiss) var dismiss
 
    var body: some View {
        VStack {
            Button {
                dismiss()
            } label: {
                Text("취소")
            }

        }
    }
}

//struct AnswerView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnswerView(todayEmoji: "proud")
//    }
//}
