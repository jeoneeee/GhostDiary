//
//  AnswerStore.swift
//  GhostDiary
//
//  Created by 이지연 on 2023/01/15.
//

import Foundation
import FirebaseFirestore

class AnswerStore: ObservableObject {
    @Published var questions: [Question] = [] // 내가 대답한 질문들
    @Published var answers: [Answer] = [] // 내가 대답한 답변들
    
    
    let database = Firestore.firestore().collection("Questions")
    
    //사용자가 작성한 답변 추가
    func createAnswer(_ questionId: String, answer: Answer) async {
        do {
            try await database
                .document(questionId).collection("Answers")
                .document(answer.id)
                .setData(["id": answer.id,
                          "uid": answer.uid,
                          "expression": answer.expression,
                          "content": answer.content,
                          "timestamp": answer.timestamp])
        } catch {
            print("creatAnswers error : \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - 사용자가 작성한 답변을 가져오는 메소드
    /// - Parameter user: 로그인한 사용자의 user정보를 가지고 있습니다
    ///
    /// 사용자가 작성한 답변을 가져오는 메소드입니다
    func readAnswer(_ user: User) async {
        do {
            let questionSnapshot = try await database
                .whereField("number", isLessThanOrEqualTo: user.questionNum)
                .getDocuments()
            
            for document in questionSnapshot.documents {
                print("document.documentID: \(document.documentID)")
            }
            
        } catch {
            print("qestion get error: \(error.localizedDescription)")
        }
    }
}

