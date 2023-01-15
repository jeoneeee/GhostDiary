//
//  Question.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI



struct Question: Codable, Identifiable {
    var id: String
    var number: String // 질문 번호
    var query: String
    
    var createdDate: String { // 현재 시간 받아오기
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd" // "yyyy-MM-dd HH:mm:ss"
        
        let dateCreatedAt = dateFormatter.string(from: Date())
        
        return dateCreatedAt
    }
}
