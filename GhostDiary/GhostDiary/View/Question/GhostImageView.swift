//
//  GhostImageView.swift
//  GhostDiary
//
//  Created by 이지연 on 2022/12/18.
//

import SwiftUI

struct GhostImageView: View {
    @State private var rotation: CGFloat = -100
    @State private var isrotating: CGFloat = -1
    
    var body: some View {
        VStack {
            HStack {
                Image("1")
                    .resizable()
                    .frame(width: 100, height: 110)
                    .offset(x: rotation)
                    .scaleEffect(x: isrotating, y: 1, anchor: .center)
                    .onAppear {
                        withAnimation(.linear(duration: 1)
                            .speed(0.2).repeatForever(autoreverses: true)) {
                                
                                rotation = 90
                                
                            }
                    }
            }
            
            HStack {
                Spacer()
                Image("2")
                    .resizable()
                    .frame(width: 110, height: 110)
                    .scaleEffect(x: isrotating, y: 1, anchor: .center)
            }
            .padding(.trailing, 50)
            HStack {
                Image("3")
                    .resizable()
                    .frame(width: 90, height: 110)
                    .offset(x: rotation)
                    .scaleEffect(x: isrotating, y: 1, anchor: .center)
                    .onAppear {
                        withAnimation(.linear(duration: 1)
                            .speed(0.2).repeatForever(autoreverses: true)) {
                                rotation = 90 //rotation 값을 기준으로 이동하는 최대, 최소 좌표
                            }
                    }
                    .onChange(of: rotation) { roc in
                        print("rotation : \(roc)")
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
