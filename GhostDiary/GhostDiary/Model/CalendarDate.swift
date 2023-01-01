//
//  CalendarDate.swift
//  GhostDiary
//
//  Created by 이학진 on 2023/01/01.
//

import Foundation

struct CalendarDate: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
