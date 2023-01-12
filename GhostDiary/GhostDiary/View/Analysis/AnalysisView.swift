//
//  AnalysisView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

struct AnalysisView: View {
    @State private var year = 2023
    @State private var month = 1
    @StateObject var questionStore: QuestionStore = QuestionStore()
    
    var body: some View {
        VStack {
            HStack {
                
                Button {
                    if month > 1 {
                        month -= 1
                    } else {
                        year -= 1
                        month = 12
                    }
                } label: {
                    Image(systemName:"chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }

              Text("\(String(year))년 \(month)월")
                    .modifier(TitleTextModifier())
                    .padding(.horizontal, 60)
                
                Button {
                    if month < 12 {
                        month += 1
                    } else {
                        year += 1
                        month = 1
                    }
                } label: {
                    Image(systemName:"chevron.right")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            } // HStack
            
            Heatmap(matrix: questionStore.matrix)
                .frame(width: 150, height: 150)
        }
    }
}

struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisView()
    }
}
