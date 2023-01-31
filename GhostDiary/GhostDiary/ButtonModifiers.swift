//
//  ButtonModifiers.swift
//  GhostDiary
//
//  Created by 이학진 on 2023/01/31.
//

import SwiftUI

struct LoginButton: ViewModifier {
    var backgroudColor: Color
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: UIScreen.main.bounds.width)
            .foregroundColor(.white)
            .background(backgroudColor)
            .cornerRadius(12)
    }
}
