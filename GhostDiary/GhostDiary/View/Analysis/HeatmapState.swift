//
//  HeatmapState.swift
//  GhostDiary
//
//  Created by 이지연 on 2023/01/13.
//


import SwiftUI

struct HeatmapState: View {
    //MARK: Property Wrapper
    @Environment(\.colorScheme) var colorScheme
    
    //MARK: Property
    let day: DailyUsageState
    
    var body: some View {
        if Calendar.current.isDateInToday(day.date) {
            RoundedRectangle(cornerRadius: 2)
                .stroke(.foreground, style: StrokeStyle(lineWidth: 1))
                .background(RoundedRectangle(cornerRadius: 2).fill(color(of: day)))
                .aspectRatio(1, contentMode: .fit)
            
        } else {
            RoundedRectangle(cornerRadius: 2)
                .fill(color(of: day))
                .aspectRatio(1, contentMode: .fit)
        }
    }
    
    func color(of day: DailyUsageState) -> Color {
        switch day.count {
        case 0:
            return colorScheme == .dark
            ? Color(uiColor: .secondarySystemGroupedBackground)
            : Color(hex: "#eaeaea")
        case 1:
            return Color(hex: "#9be9a8")
        case 2:
            return Color(hex: "#40c463")
        case 3...4:
            return Color(hex: "#30a14e")
        default:
            return Color(hex: "#216e39")
        }
    }
}

struct HeatmapState_Previews: PreviewProvider {
    static var previews: some View {
        HeatmapState(day: DailyUsageState(date: .now, count: 1))
    }
}
