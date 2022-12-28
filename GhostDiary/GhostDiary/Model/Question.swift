//
//  Question.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI



struct Question: Codable, Identifiable {
    var id: String // 질문 번호
    var query: String
}
