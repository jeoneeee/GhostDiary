//
//  User.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var email: String
    var currentQuestionNum: String //어디까지 대답을 했는지 나타내는 숫자
    var loginTime: String
    var timestamp: String // 회원 가입한 시간
}



//currentQuestionNum AnswerView -> 질문 제출 currentQuestionNum+1 / fetchData를 하루 지나면 하기로...
