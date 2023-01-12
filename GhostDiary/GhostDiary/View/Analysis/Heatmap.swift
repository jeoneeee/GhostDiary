//
//  Heatmap.swift
//  GhostDiary
//
//  Created by 이지연 on 2023/01/13.
//

import SwiftUI

fileprivate let gridSpacing: CGFloat = 3
fileprivate let defaultRows = [GridItem](repeating: GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: gridSpacing), count: daysInWeek)
fileprivate let daysInWeek = Calendar.current.weekdaySymbols.count

struct Heatmap: View {
    //MARK: Property
    let rows = defaultRows
    let matrix: [DailyUsageState]
    
    var body: some View {
        GeometryReader { geometry in
            LazyHGrid(rows: rows, alignment: .top, spacing: gridSpacing) {
                ForEach(matrix.suffix(count(in: geometry.frame(in: .local).size))) { day in
                    HeatmapState(day: day)
                }
            }
        }
    }
        
    private func count(in size: CGSize) -> Int {
        let cellHeight = size.height / CGFloat(daysInWeek)
        if cellHeight <= 0 {
            return 0
        }
        let cellWidth = cellHeight
        let columns = Int(floor(size.width / cellWidth))
        let fullCells = Int(columns) * daysInWeek
        
        let today = Calendar.current.startOfDay(for: .now)
        let weekday = Calendar.current.dateComponents([.weekday], from: today).weekday!
        let lastColumn = (weekday + 1) - Calendar.current.firstWeekday
        if lastColumn % daysInWeek == 0 {
            return fullCells
        }
        return fullCells - daysInWeek + lastColumn
    }
}

struct HeatMap_Previews: PreviewProvider {
    static var previews: some View {
        Heatmap(matrix: DailyUsageState.initialMatrix)
    }
}
