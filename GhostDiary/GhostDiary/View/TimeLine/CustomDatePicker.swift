//
//  CustomDatePicker.swift
//  GhostDiary
//
//  Created by 이학진 on 2023/01/01.
//

import SwiftUI

struct CustomDatePicker: View {
    @EnvironmentObject var authStores: AuthStore
    @StateObject var timelineStores = TimeLineStore()
    @Binding var currentDate: Date
    
    @EnvironmentObject var answerStores: AnswerStore
    
    // Month update on arrow button
    @State var currentMonth: Int = 0
    
    let days: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    
    var today: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let currentToday = formatter.string(from: Date())
        return Int(currentToday) ?? -1
    }
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Spacer()
                
                Button {
                    currentMonth -= 1
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Text("\(extraData()[0])년")
                    .modifier(TitleTextModifier())
                Text("\(extraData()[1])")
                    .modifier(TitleTextModifier())
                
                Button {
                    currentMonth += 1
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
                
                Spacer()
            }
            .foregroundColor(.black)
            .padding(.horizontal)
            
            // 요일 뷰
            VStack {
                HStack(spacing: 5) {
                    ForEach(days, id: \.self) { day in
                        Text(day)
                            .frame(maxWidth: .infinity)
                            .modifier(BodyTextModifier())
                    }
                }
                // 날짜 뷰
                let columns = Array(repeating: GridItem(.flexible()), count: 7)
                
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(extractDate()) { value in
                        CardView(value: value)
                    }
                }
            }
        }
        // 날짜 변경
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: CalendarDate) -> some View {
        VStack {
            if value.day != -1 {
                VStack(spacing: 3) {
                    if value.date.getDay() == Date().getDay() { // 오늘 날짜인 경우
                        Text("\(value.day)")
                            .modifier(CaptionTextModifier())
                            .background {
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color("Color8"))
                            }
                    } else {
                        Text("\(value.day)")
                            .modifier(CaptionTextModifier())
                    }
                    
                    let answer = answerStores.answers
                        .filter {$0.timestamp.getDay() == value.date.getDay() }
                        .first
                    
                    answerView(answer: answer)
                }
            }
        }
    }
    
    // MARK: - 자신이 대답한 감정을 보여주는 뷰
    /// - Parameter answer: 해당일에 자신이 대답한 데이터를 가지고 있으며 타입은 옵셔널이다.
    ///
    /// nil일 경우 대답이 존재하지 않으므로 빈 뷰를 보여주며 대답이 담긴 경우
    /// NavigationLink로 생성되며 해당일에 대답한 질문과 대답 데이터를 AnswerDetailView에 넘긴다.
    @ViewBuilder
    func answerView(answer: Answer?) -> some View {
        if let answer {
            let index = answerStores.answers.firstIndex {$0.id == answer.id}!

            NavigationLink {
                AnswerDetailView(question: answerStores.questions[index], answer: answerStores.answers[index])
            } label: {
                Image(answer.expression)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
            }
        } else {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(Color(UIColor.systemGray6))
        }
    }
    
    // MARK: - currentDate을 기준으로 년도와 일을 문자열 배열로 반환하는 메소드
    /// 반환값: ex) [2023, 4월]
    func extraData() -> [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    // MARK: - 월을 변경하는 버튼을 눌렀을때 호출되는 메소드로 현재 화면에 보이는 월을 반환한다.
    /// 반환값: 현재 2023년 4월을 보고있다면 currentMonth: 2023-04-18 11:46:36 +0000
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else { return Date() }
        return currentMonth
    }
    
    // MARK: - 일 정보를 반환하는 메소드
    /// 반환값은 CalendarDate 타입의 배열이다.
    /// 현재 화면에 보고 있는 달력의 날짜들을 CalendarDate 타입으로 반환한다.
    /// 달력의 첫줄에 비어있는 칸은 day 프로퍼티의 값이 -1이다.
    func extractDate() -> [CalendarDate] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        
        // 현재 달력의 Date타입의 값들을 custom model인 CalendarDate로 변환하는 작업
        var days =  currentMonth.getAllDates().compactMap { date -> CalendarDate in
            let day = calendar.component(.day, from: date)
            return CalendarDate(day: day, date: date)
        }
        
        // 현재 월의 첫날이 달력의 시작부터 얼마나 떨어져있는지 계산하는 로직
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        for _ in 0..<firstWeekday - 1 {
            days.insert(CalendarDate(day: -1, date: Date()), at: 0)
        }
        return days
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(AuthStore())
            .environmentObject(AnswerStore())
    }
}
