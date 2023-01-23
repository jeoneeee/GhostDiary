//
//  CalendarStore.swift
//  GhostDiary
//
//  Created by 이학진 on 2023/01/18.
//

import Foundation

// MARK: CalendarView에서 Date 처리를 해주는 구조체
struct CalendarStore {
    // MARK: - currentDate을 기준으로 년도와 일을 문자열 배열로 반환하는 메소드
    /// 반환값: ex) [2023, 4월]
    func extraData(_ currentDate: Date) -> [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    // MARK: - 월을 변경하는 버튼을 눌렀을때 호출되는 메소드로 현재 화면에 보이는 월을 반환한다.
    /// 반환값: 현재 2023년 4월을 보고있다면 currentMonth: 2023-04-18 11:46:36 +0000
    func getCurrentMonth(_ month: Int) -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: month, to: Date()) else { return Date() }
        return currentMonth
    }
    
    // MARK: - 일 정보를 반환하는 메소드
    /// 반환값은 CalendarDate 타입의 배열이다.
    /// 현재 화면에 보고 있는 달력의 날짜들을 CalendarDate 타입으로 반환한다.
    /// 달력의 첫줄에 비어있는 칸은 day 프로퍼티의 값이 -1이다.
    func extractDate(_ month: Int) -> [CalendarDate] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth(month)
        
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
