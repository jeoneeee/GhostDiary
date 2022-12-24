//
//  User.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var email: String
    var timestamp: String // 회원 가입한 시간
}


