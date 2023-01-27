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
    let text = ["화남", "기쁨", "뿌듯", "슬픔", "지침", "무난"]
    @State var steps = Array(repeating: 0, count: 6)
    @EnvironmentObject var answerStore: AnswerStore
    @EnvironmentObject var authStore: AuthStore
    var angryCount: Int {
        let angryArray = answerStore.answers.filter{$0.expression == "angry"}
        return angryArray.count
    }
    var cuteCount: Int {
        let cuteArray = answerStore.answers.filter{$0.expression == "cute"}
        return cuteArray.count
    }
    var proudCount: Int {
        let proudArray = answerStore.answers.filter{$0.expression == "proud"}
        return proudArray.count
    }
    var sadCount: Int {
        let sadArray = answerStore.answers.filter{$0.expression == "sad"}
        return sadArray.count
    }
    var tiredCount: Int {
        let tiredArray = answerStore.answers.filter{$0.expression == "tired"}
        return tiredArray.count
    }
    var ummCount: Int {
        let ummArray = answerStore.answers.filter{$0.expression == "umm"}
        return ummArray.count
    }
    
    var body: some View {
            VStack {
                Chart {
                    ForEach(emoji.indices, id: \.self) { index in
                        BarMark(x: .value("Emoji", text[index]), y: .value("Steps", steps[index]))
                            .foregroundStyle(by: .value("Texts", text[index]))
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
                    "화남": Color("Color8"), "기쁨": Color("Color3"), "뿌듯": Color("Color4"), "슬픔": Color("Color1"), "지침": Color("Color6"), "무난": Color("Color7")
                ])
                .frame(height: 400)                
            }
            .onAppear {
                steps = [angryCount,cuteCount,proudCount,sadCount,tiredCount,ummCount]
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
