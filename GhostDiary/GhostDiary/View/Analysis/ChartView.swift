//
//  ChartView.swift
//  GhostDiary
//
//  Created by 이지연 on 2023/01/20.
//

import SwiftUI
import Charts

struct ChartView: View {
    let emoji = ["angry", "cute", "proud", "sad", "tired", "umm"]
    let text = ["1", "2", "3", "4", "5", "6"]
    let steps = [1,2,3,4,5,6]
    @EnvironmentObject var answerStore: AnswerStore
    @EnvironmentObject var authStore: AuthStore
    
    var body: some View {
            VStack {
                Chart {
                    ForEach(emoji.indices, id: \.self) { index in
                        BarMark(x: .value("Emoji", text[index]), y: .value("Steps", steps[index]))
                            .foregroundStyle(by: .value("Day", text[index]))
                            .annotation(position: .top) {
                                VStack {
                                    Text("\(steps[index])")
                                        .modifier(CaptionTextModifier())
                                    Image(emoji[index])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                }
                            }
                    }
                }
                .chartForegroundStyleScale([
                    "1": Color("Color8"), "2": Color("Color3"), "3": Color("Color4"), "4": Color("Color1"), "5": Color("Color6"), "6": Color("Color7")
                ])
                .frame(height: 400)
                
//                ForEach(answerStore.answers) { idx in
//                    Text("expression = \(idx.expression.count)")
//                }
                Text("Gd")
                
            }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisView()
            .environmentObject(AuthStore())
            .environmentObject(AnswerStore())
    }
}
