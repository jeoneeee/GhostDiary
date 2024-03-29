//
//  Answer.swift
//  GhostDiary
//
//  Created by 이지연 on 2022/12/28.
//

import Foundation
import SwiftUI

enum Expression: String {
    case angry
    case sad
    case proud
    case cute
    case smile
    case umm
    case tired
}

enum AnswerStatus {
    case notAnswerd
    case answered
}

struct Answer: Identifiable, Hashable, Codable {
    var id: String
    var uid: String // user의 uid
    var expression: String // sad, angry
    var content: String // 대답 텍스트필드 값
    var timestamp: Date
    
    var image: Image {
        let name = Expression(rawValue: expression) ?? .smile
        return Image(name.rawValue)
    }
    
}
