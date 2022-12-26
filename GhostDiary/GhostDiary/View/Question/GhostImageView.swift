//
//  GhostImageView.swift
//  GhostDiary
//
//  Created by 이지연 on 2022/12/18.
//

import SwiftUI

struct GhostImageView: View {
    @State private var rotation1: CGFloat = -100
    @State private var rotation2: CGFloat = 20
    @State private var isrotating: CGFloat = -1
    
    var body: some View {
        VStack {
            HStack {
                Image("ghost1")
                    .resizable()
                    .frame(width: 100, height: 110)
                    .offset(x: rotation1)
                    .onAppear {
                        withAnimation(.linear(duration: 1)
                            .speed(0.2).repeatForever(autoreverses: true)) {
                                
                                rotation1 = 90
                                
                            }
                    }
            }
            
            HStack {
                Spacer()
                Image("ghost2")
                    .resizable()
                    .frame(width: 110, height: 110)
                    .offset(x: rotation2)
                    .onAppear {
                        withAnimation(.linear(duration: 1)
                            .speed(0.2).repeatForever(autoreverses: true)) {
                                
                                rotation2 = -190
                                
                            }
                    }

            }
            .padding(.trailing, 50)
            HStack {
                Image("ghost3")
                    .resizable()
                    .frame(width: 90, height: 110)
                    .offset(x: rotation1)
                    .onAppear {
                        withAnimation(.linear(duration: 1)
                            .speed(0.2).repeatForever(autoreverses: true)) {
                                rotation1 = 90 //rotation 값을 기준으로 이동하는 최대, 최소 좌표
                            }
                    }
            }
        }
        .padding(.leading, 50)
    } //VStack
}


struct GhostImageView_Previews: PreviewProvider {
    static var previews: some View {
        GhostImageView()
    }
}
