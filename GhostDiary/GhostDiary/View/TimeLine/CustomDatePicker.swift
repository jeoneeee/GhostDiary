//
//  CustomDatePicker.swift
//  GhostDiary
//
//  Created by 이학진 on 2023/01/01.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var currentDate: Date
    
    // Month update on arrow button
    @State var currentMonth: Int = 0
    
    var body: some View {
        VStack(spacing: 35) {
            // Days...
            let days: [String] = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"]
            
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
            
            // Day View
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Dates
            // LazyVgrid
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()) { value in
                    CardView(value: value)
                }
                
            }
            
            
        }
        .onChange(of: currentMonth) { newValue in
            // Updating Month..
            
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: CalendarDate) -> some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.title3.bold())
            }
        }
        .padding(.vertical, 8)
        .frame(height: 60, alignment: .top)
    }
    
    // extracting year and month for display
    func extraData() -> [String] {
        let formatter = DateFormatter()
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
