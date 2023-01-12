//
//  QuestionStore.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import Foundation
import FirebaseFirestore

class QuestionStore: ObservableObject {
    @Published var questions: Question = Question(id: "", query: "")
    @Published var matrix: [DailyUsageState] = DailyUsageState.initialMatrix
    
    let database = Firestore.firestore()
    
    
    //데이터베이스에 저장된 정보들을 불러옴
    func fetchQuestions() {
        let userCurrentQuestionNum = "1"
        
        let document = database.collection("Questions")
            .document(userCurrentQuestionNum)
        
        document.getDocument { (document, error) in
            if let document = document, document.exists {

                let docData = document.data()
                
                let id: String = document.documentID
                let query: String = docData?["query"] as? String ?? ""
                
                self.questions = Question(id: id, query: query)

            }
        }
    }
}


