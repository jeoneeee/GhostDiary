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
            // Days...
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(extraData()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(extraData()[1])
                        .font(.title.bold())
                }
                
                Spacer(minLength: 0)
                
                Button {
                    currentMonth -= 1
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                Button {
                    currentMonth += 1
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
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
                    if value.day == today { // 오늘 날짜인 경우
                        Text("\(value.day)")
                            .modifier(CaptionTextModifier())
                            .background {
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.pink)
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
    
    // extracting year and month for display
    func extraData() -> [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        print("ss : \(date.components(separatedBy: " "))")
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else { return Date() }
        
        return currentMonth
    }
    
    func extractDate() -> [CalendarDate] {
        // Getting Current Month Date
        
        let calendar = Calendar.current
        print("calendar: \(calendar)")
        
        let currentMonth = getCurrentMonth()
        
        var days =  currentMonth.getAllDates().compactMap { date -> CalendarDate in
            let day = calendar.component(.day, from: date)
            
            return CalendarDate(day: day, date: date)
        }

        // adding offeset days
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
