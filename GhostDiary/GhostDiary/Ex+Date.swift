//
//  Ex+Date.swift
//  GhostDiary
//
//  Created by 이학진 on 2023/01/17.
//

import Foundation

// Extending Date to get Current Month Dates
extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        // getting start Date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        // getting date
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
    
    // MARK: - 입력받은 date를 일 (11일 or 15일)로 변환하는 메소드
    func getDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "ko_KR")
        
        return dateFormatter.string(from: self)
    }
}
