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
    @Binding var year: Int
    @Binding var month: Int
    
    var currentAnswer: [Answer] {
        return answerStore.answers.filter {Int($0.timestamp.getYear())! == year && Int($0.timestamp.getMonth())! == month}
    }
    
    var angryCount: Int {
        let angryArray = currentAnswer.filter{$0.expression == "angry"}
        return angryArray.count
    }
    var cuteCount: Int {
        let cuteArray = currentAnswer.filter{$0.expression == "cute"}
        return cuteArray.count
    }
    var proudCount: Int {
        let proudArray = currentAnswer.filter{$0.expression == "proud"}
        return proudArray.count
    }
    var sadCount: Int {
        let sadArray = currentAnswer.filter{$0.expression == "sad"}
        return sadArray.count
    }
    var tiredCount: Int {
        let tiredArray = currentAnswer.filter{$0.expression == "tired"}
        return tiredArray.count
    }
    var ummCount: Int {
        let ummArray = currentAnswer.filter{$0.expression == "umm"}
        return ummArray.count
    }
    
    var body: some View {
            VStack {
                var _ = print("\(year)년 \(month)의 Answers: \(currentAnswer)")
                if steps == Array(repeating: 0, count: 6) {
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        .resizable()
                        .frame(width: UIScreen.screenWidth*0.2, height: UIScreen.screenHeight*0.1)
                        .padding(.bottom, 20)
                    Text("기록된 감정이 없어요.")
                        .modifier(TitleTextModifier())
                } else {
                    Chart {
                        ForEach(emoji.indices, id: \.self) { index in
                            BarMark(x: .value("Emoji", text[index]), y: .value("Steps", steps[index]))
                                .foregroundStyle(by: .value("Texts", text[index]))
                                .annotation {
                                    VStack {
                                        Text("\(steps[index])")
                                            .modifier(CaptionTextModifier())
                                        Image(emoji[index])
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenWidth*0.08)
                                    }
                                }
                        }
                    }
                    .chartForegroundStyleScale([
                        "화남": Color("Color8"), "기쁨": Color("Color3"), "뿌듯": Color("Color4"), "슬픔": Color("Color1"), "지침": Color("Color6"), "무난": Color("Color7")
                    ])
                }
            }//VStack
            .onAppear {
                steps = [angryCount,cuteCount,proudCount,sadCount,tiredCount,ummCount]
            }
            .onChange(of: month) { _ in
                steps = [angryCount,cuteCount,proudCount,sadCount,tiredCount,ummCount]
            }
    }
}

struct ChartView_Previews: PreviewProvider {
    @State static private var isLogin: Bool = false
    static var previews: some View {
        AnalysisView(isLogin: $isLogin)
            .environmentObject(AuthStore())
            .environmentObject(AnswerStore())
    }
}
