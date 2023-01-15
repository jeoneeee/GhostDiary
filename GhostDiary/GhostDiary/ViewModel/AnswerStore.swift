//
//  AnswerStore.swift
//  GhostDiary
//
//  Created by 이지연 on 2023/01/15.
//

import Foundation
import FirebaseFirestore

class AnswerStore: ObservableObject {
    
    let database = Firestore.firestore()
    
    
    //사용자가 작성한 답변 추가
    func createAnswer(_ questionId: String, answer: Answer) async {

        do {
            try await database.collection("Questions")
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
}

