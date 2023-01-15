//
//  DailyUsageState.swift
//  GhostDiary
//
//  Created by 이지연 on 2023/01/13.
//

import Foundation

struct DailyUsageState: Identifiable {
    let date: Date
    var count: Int
    
    var id: String {
        date.formatted(date: .numeric, time: .omitted)
    }
    
    static let initialMatrix: [DailyUsageState] = {
        let today = Calendar.current.startOfDay(for: .now)
        
        return Calendar.current.range(of: .day, in: .year, for: Date())!.map { day in
            return Self.init(date: Calendar.current.date(byAdding: .day, value: 1 - day, to: today)!, count: 0)
        }.reversed()
    }()
    
//    static func calculateMatrix(noteList: [Answer]) -> [DailyUsageState] {
//        var result = DailyUsageState.initialMatrix
//        var countDict = [String: Int]()
//        
//        for note in noteList {
//            let key = note.createdAt.formatted(date: .numeric, time: .omitted)
//            countDict[key] = (countDict[key] ?? 0) + 1
//        }
//        
//        for (i, day) in result.enumerated() {
//            result[i].count = countDict[day.id] ?? 0
//        }
//        
//        return result
//    }
}
