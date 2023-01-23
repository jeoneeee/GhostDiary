//
//  TextModifiers.swift
//  GhostDiary
//
//  Created by 이지연 on 2023/01/12.
//

import Foundation
import SwiftUI

// MARK: - Modifier : Title 크키 폰트 속성
struct TitleTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("나눔손글씨 느릿느릿체", size: 34))
    }
}

// MARK: - Modifier : Body 크키 폰트 속성
struct BodyTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("나눔손글씨 느릿느릿체", size: 28))
    }
}

// MARK: - Modifier : Caption 크키 폰트 속성
struct CaptionTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("나눔손글씨 느릿느릿체", size: 22))
    }
}
