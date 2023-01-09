//
//  CustomDatePicker.swift
//  GhostDiary
//
//  Created by 이학진 on 2023/01/01.
//

import SwiftUI

struct CustomDatePicker: View {
    @EnvironmentObject var authStores: AuthStore
    @Binding var currentDate: Date
    
    // Month update on arrow button
    @State var currentMonth: Int = 0
    
    let days: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    
    var today: Int {
        var formatter = DateFormatter()
        formatter.dateFormat = "dd"
        var currentToday = formatter.string(from: Date())
        
        print(currentToday)
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
                HStack(spacing: 10) {
                    ForEach(days, id: \.self) { day in
                        Text(day)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                }
                // 날짜 뷰
                let columns = Array(repeating: GridItem(.flexible()), count: 7)
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(extractDate()) { value in
                        CardView(value: value)
                            .padding(.bottom)
                        
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
                VStack {
                    if value.day == today { // 오늘 날짜인 경우
                        Text("\(value.day)")
                            .font(.caption.bold())
                            .background {
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.pink)
                            }
                        
                    } else {
                        Text("\(value.day)")
                            .font(.caption.bold())
                    }
                    // FIXME: - 해당 날짜에 질문을 한 경우로 조건을 변경해야 함x
                    if value.day % 3 == 0 {
                        Image("smile")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                    } else {
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(UIColor.systemGray6))
                    }
                }
            }
        }
        //.frame(height: 60, alignment: .top)
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
    }
}


// Extending Date to get Current Month Dates

extension Date {
    
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        // getting start Date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        print("range: \(range)")
        
        // getting date
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
        
    }
    
}
