//
//  QuestionStore.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import Foundation
import FirebaseFirestore

class QuestionStore: ObservableObject {
    @Published var questions: [Question] = []
    
    let database = Firestore.firestore()
    
    init() {
        /*
         postits = [
         Postit(id: UUID().uuidString, user: "ned", memo: "Good morning", colorIndex: 0, createdAt: Date().timeIntervalSince1970),
         
         Postit(id: UUID().uuidString, user: "ned", memo: "Good evening", colorIndex: 1, createdAt: Date().timeIntervalSince1970),
         
         Postit(id: UUID().uuidString, user: "ned", memo: "Hello World", colorIndex: 2, createdAt: Date().timeIntervalSince1970),
         
         Postit(id: UUID().uuidString, user: "ned", memo: "Hello my friend", colorIndex: 3, createdAt: Date().timeIntervalSince1970)
         ]
         */
        questions = []
    }
    
    
    //데이터베이스에 저장된 정보들을 불러옴
    func fetchQuestions() {
        database.collection("Questions") // 데이터베이스의 Posts라는 이름의 컬렉션에서
            .getDocuments { (snapshot, error) in // 문서들을 가져옴
                self.questions.removeAll()
                
                // 비어있지 않다면 그 값들을 [Post]배열에 담음
                //snapshot: 특정 시점에 사진 처럼 찰칵 찍어서 저장된 파일(collection의 문서)의 상태를 가져옴. -> 가져온 문서들을 반복문으로 사용할수 있음
                if let snapshot {
                    for document in snapshot.documents {
                        //파이어베이스상의 문서 고유아이디
                        let id: String = document.documentID
                        
                        let docData = document.data()
                        let query: String = docData["query"] as? String ?? ""
                        let queryNums: Int = docData["queryNums"] as? Int ?? 0
                        let expression: String = docData["expression"] as? String ?? ""
                        let timestamp: String = docData["timestamp"] as? String ?? ""
                        
                        
                        let question: Question = Question(id: id, query: query, queryNums: queryNums, expression: expression, timestamp: timestamp)
                        
                        self.questions.append(question)
                    }
                }
            }
    }
}


