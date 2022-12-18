//
//  Authorization.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/18.
//

import Foundation

//FIXME: - 이메일 유효성 수정 예정
struct AuthCheck {
    static func validateEmail(email : String) -> Bool {
        // "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        // #"^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"#
        let regExp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return email.range(of: regExp, options: .regularExpression) != nil
    }
    
    static func validatePassword(password : String) -> Bool {
        let regExp = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}$"
        return password.range(of: regExp, options: .regularExpression) != nil
    }
}
