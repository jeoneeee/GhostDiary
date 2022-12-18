//
//  HomeView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Spacer()
            GhostImageView()
            Spacer()
            QuestionBoxView()
                .padding(.bottom, 30)
            //offset이였는데 학진님 아이디어 굳..
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
