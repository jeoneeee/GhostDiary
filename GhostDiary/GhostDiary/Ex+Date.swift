//
//  Ex+Date.swift
//  GhostDiary
//
//  Created by 이학진 on 2023/01/17.
//

import Foundation

extension Date {
    // MARK: - 현재 호출하는 Date값의 달의 날짜 정보들을 출력하는 메소드
    /// 현재 2023년 4월의 값을 가진 date가 메소드를 호출했다면
    /// 4월의 date값들을 배열에 담아 반환한다.
    /// ex) [2023-02-28 15:00:00 +0000, 2023-03-01 15:00:00 +0000]
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
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
