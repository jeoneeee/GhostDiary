//
//  Question.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

enum Expression: String {
    case angry = "angry"
    case sad = "sad"
    case proud = "proud"
    case cute = "cute"
    case smile = "smile"
    case umm = "umm"
    case tired = "tired"
}

struct Question: Codable, Identifiable {
    var id: String
    var query: String
    var answer: String
    var expression: String // sad, angry
    var timestamp: String
    
    var image: Image {
        let name = Expression(rawValue: expression) ?? .smile
        return Image(name.rawValue)
    }
}
