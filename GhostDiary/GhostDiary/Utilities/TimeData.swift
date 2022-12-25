//
//  TimeData.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/18.
//

import Foundation

struct TimeData {
    static func getTimeStrings(_ date: Date = Date(timeIntervalSince1970: Date().timeIntervalSince1970)) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // "yyyy-MM-dd HH:mm:ss"
        
        let dateCreatedAt = date
        let date = dateFormatter.string(from: dateCreatedAt)
        
        return date
    }
}
