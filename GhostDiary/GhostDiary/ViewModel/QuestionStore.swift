//
//  QuestionStore.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import Foundation
import FirebaseFirestore
import FirebaseCore
import Firebase

@MainActor
class QuestionStore: ObservableObject {
    @Published var questions: Question = Question(id: "", number: "", query: "")
    
    let database = Firestore.firestore()
    
    let questionSize: Int = 54 // 현재 데이터 베이스에 저장된 질문의 개수
    
    
    //데이터베이스에 저장된 정보들을 불러옴
    func fetchQuestions(user: User) async {
        
        let result = await isCheckingQuestion(user: user)
         
        if result {
            // questionNum + 1
            do {
                let querysnapshot = try await database.collection("Questions")
                    .whereField("number", isEqualTo: user.questionNum + 1) // Questions에서 "number" 가 user.questionNom + 1 인 값을 가져온다
                    .getDocuments()
                
                // 내용이 한개지만 배열 값으로 저장되어서 배열 첫번째 값을 불러온다.
                for document in querysnapshot.documents {
                    let id: String = document["id"] as? String ?? ""
                    let number: String = document["number"] as? String ?? ""
                    let query: String = document["query"] as? String ?? ""

                    self.questions = Question(id: id, number: number, query: query)
                }

                do { // user애 questionNum 값에 1을 더해 업데이트
                    try await database.collection("users").document(user.id)
                        .updateData([
                            "questionNum": min((user.questionNum + 1), questionSize)
                        ])
                } catch {
                    print("user question number update error : \(error.localizedDescription)")
                }

            } catch {
                print("fetchQuestions error : \(error.localizedDescription)")
            }

        } else {
            // questionNum
            do {
                let querysnapshot = try await database.collection("Questions")
                    .whereField("number", isEqualTo: user.questionNum)
                    .getDocuments()

                for document in querysnapshot.documents {
                    let id: String = document["id"] as? String ?? ""
                    let number: String = document["number"] as? String ?? ""
                    let query: String = document["query"] as? String ?? ""

                    self.questions = Question(id: id, number: number, query: query)
                }
            } catch {
                print("fetchQuestions error : \(error.localizedDescription)")
            }
        }

    }
    
    func isCheckingQuestion(user: User) async -> Bool { // 질문 업데이트 체크 함수, 반환값이 true일 때 user.questionNum + 1
        do {
            print("user = \(user)")
            let querysnapshot = try await database.collection("Questions")
                .whereField("number", isEqualTo: user.questionNum)
                .getDocuments()

            var documentId = ""
            
            for document in querysnapshot.documents {
                documentId = document.documentID
            }
            print("documentId = \(documentId)")
            
            
           let answerData = try await database.collection("Questions") // ERROR ISSUE -> 변수 선언 까먹음..
                .document(documentId)
                .collection("Answers")
                .whereField("uid", isEqualTo: user.id) // Answers 컬렉션 안에 자신의 아이디 값이 포함된 필드가 있는지 찾는다..
                .getDocuments()
            
            if !answerData.isEmpty {
                let document = answerData.documents.first! // 내가 대답한 다큐먼트
                print("documentId = \(document.documentID)")
                let docData = document.data()
                let timestamp: Timestamp = docData["timestamp"] as? Timestamp ?? Timestamp()
                let answerTime = timestamp.dateValue()
                print("*****answerTime**** = \(answerTime)")
                print("date = \(Date())")
                
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "ko_kr")
                formatter.timeZone = TimeZone(abbreviation: "KST")
                formatter.dateFormat = "yyyy-MM-dd"
                let answerDay = formatter.string(from: answerTime) // 해당 질문에 대답한 날짜
                let currentDay = formatter.string(from: Date()) // 현재 날짜
                
                print("answerDay : \(answerDay)")
                print("currentDay: \(currentDay)")
                
                if answerDay != currentDay {
                    return true
                }
            } else {
                return false
            }
            
        } catch {
            print("isCheckingQuestion error : \(error.localizedDescription)")
            return false
        }
        
        return false
    }
    
    
    func isCheckingAnswer(user: User) async -> Bool { // 질문에 따른 대답의 값이 있을경우 true로 반환
        do {
            print("user = \(user)")
            let querysnapshot = try await database.collection("Questions")
                .whereField("number", isEqualTo: user.questionNum)
                .getDocuments()

            var documentId = ""
            
            for document in querysnapshot.documents {
                documentId = document.documentID
            }
            print("documentId = \(documentId)")
            
            
           let answerData = try await database.collection("Questions") // ERROR ISSUE -> 변수 선언 까먹음..
                .document(documentId)
                .collection("Answers")
                .whereField("uid", isEqualTo: user.id) // Answers 컬렉션 안에 자신의 아이디 값이 포함된 필드가 있는지 찾는다..
                .getDocuments()
            
            if !answerData.isEmpty {
                return true
            } else {
                return false
            }
            
        } catch {
            print("isCheckingQuestion error : \(error.localizedDescription)")
            return false
        }
    }
}


