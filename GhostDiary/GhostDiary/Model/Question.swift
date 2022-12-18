//
//  Question.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

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

struct Question: Codable, Identifiable {
    var id: String
    var query: String
    var queryNums: Int
    var answer: String
    var expression: String // sad, angry
    var timestamp: String
    
    var image: Image {
        let name = Expression(rawValue: expression) ?? .smile
        return Image(name.rawValue)
    }
}
