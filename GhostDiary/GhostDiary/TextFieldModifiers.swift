//
//  TextFieldModifiers.swift
//  GhostDiary
//
//  Created by 이학진 on 2023/01/31.
//

import SwiftUI

struct LoginTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color("Color5"), lineWidth: 3)
            }
            .padding([.leading,.trailing])
    }
}
