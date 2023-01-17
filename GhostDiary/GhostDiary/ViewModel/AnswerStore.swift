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
    
    
    // MARK: - 사용자가 작성한 질문과 답변을 가져오는 메소드
    /// - Parameter user: 로그인한 사용자의 user정보를 가지고 있습니다
    ///
    /// 사용자가 작성한 답변을 가져오는 메소드입니다.
    /// 이 메소드에서 유저가 답변한 질문들을 읽으며, readAnswer 데이터로 question정보를 전달하여
    /// 질문에 해당하는 답변을 얻습니다
    func readQuestionAndAnswer(_ user: User) async {
        do {
            let questionSnapshot = try await database
                .whereField("number", isLessThanOrEqualTo: user.questionNum)
                .getDocuments()
            
            for document in questionSnapshot.documents {
                let data = document.data()
                
                let id = data["id"] as? String ?? ""
                let number = data["number"] as? String ?? ""
                let query = data["query"] as? String ?? ""
                
                let question = Question(id: id,
                                        number: number,
                                        query: query)
                
                print("question: \(question)")
                
                await readAnswer(user.id, question: question)
                
                DispatchQueue.main.async {
                    self.questions.append(question)
                }
            }
            
        } catch {
            print("qestion get error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 사용자가 작성한 답변을 가져오는 메소드
    /// - Parameter uid: 로그인한 사용자의 uid정보를 가지고 있습니다
    /// - Parameter question: 사용자가 대답한 질문의 관련된 정보입니다.
    ///
    /// readQuestionAndAnswer 메소드로부터 uid와 question 정보를 파라미터로 입력받습니다.
    /// 받은 정보를 기반으로 자신이 대답한 대답(answer)정보를 얻습니다.
    /// 얻은 정보는 클래스의 @Published property에 저장됩니다.
    
    func readAnswer(_ uid: String, question: Question) async {
        do {
            let answerSnapshot = try await database
                .document(question.id)
                .collection("Answers")
                .whereField("uid", isEqualTo: uid)
                .getDocuments()
            
            for document in answerSnapshot.documents {
                let data = document.data()
                
                let id = data["id"] as? String ?? ""
                let expression = data["expression"] as? String ?? ""
                let content = data["content"] as? String ?? ""
                
                let date = data["timestamp"] as? Timestamp ?? Timestamp()
                let timestamp = date.dateValue()
                
                let answer = Answer(id: id,
                                    uid: uid,
                                    expression: expression,
                                    content: content,
                                    timestamp: timestamp)
                print("answer: \(answer)")
                
                DispatchQueue.main.async {
                    self.answers.append(answer)
                }
            }
            
        } catch {
            print("answer get error: \(error.localizedDescription)")
        }
        
        
    }
}

