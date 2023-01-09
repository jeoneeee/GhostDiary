//
//  TimeLineStore.swift
//  GhostDiary
//
//  Created by 이학진 on 2023/01/09.
//

import Foundation
import FirebaseFirestore

class TimeLineStore: ObservableObject {
    @Published var answers: [Answer] = []
    
    private lazy var databaseReference: CollectionReference? = {
        let reference = Firestore.firestore().collection("Questions")
        return reference
    }()
    
    
    
    // MARK: - 유저가 질문에 대답한 데이터를 불러오는 메소드
    /// - Parameter uid: 로그인한 유저의 uid
    /// - Parameter answerNumber: 로그인한 유저가 대답을 해야하는 질문 번호
    ///  answerNumber가 1이면 1번 질문에 대답을 해야한다.
    func requestAnswersData(_ uid: String, answerNumber: String) async {
        if let databaseReference {
            do {
                let querySnapshot = try await databaseReference
                    .whereField("id", isLessThanOrEqualTo: answerNumber)
                    .getDocuments()
                for document in querySnapshot.documents {
                    print("document.documentID: \(document.documentID)")
                    
                    let answer = await requestAnswers(uid, documentId: document.documentID)
                    print("answer: \(answer)")
                    
                    // answer이 nil인 경우는 유저가 해당 질문에 대답을 하지 않은 경우 -> 그럴 경우는 오류임
                    if let answer {
                        await MainActor.run(body: {
                            self.answers.append(answer)
                        })
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    // MARK: - 유저가 질문에 대답한 데이터를 불러오는 메소드
    /// - Parameter uid: 로그인한 유저의 uid
    /// - Parameter documentId: 유저가 대답할 질문을 가져올 documentId(질문의 id)와 동일
    /// - Return: Answer nil인 경우는 유저가 질문에 대답을 하지 않은 경우이다.
    ///  documentId가 1이면 1번 질문에 대답을 가져온다.
    func requestAnswers(_ uid: String, documentId: String) async -> Answer? {
        print("uid: \(uid), documentId: \(documentId)")
        if let databaseReference {
            do {
                let querySnapshot = try await databaseReference
                    .document(documentId)
                    .collection("Answers")
                    .document(uid)
                    .getDocument()

                if querySnapshot.exists {
                    let document = querySnapshot.data()!

                    let id: String = document["id"] as? String ?? ""
                    let expression: String = document["expression"] as? String ?? ""
                    let content: String = document["content"] as? String ?? ""
                    let timestamp: String = document["timestamp"] as? String ?? ""
                    let answer = Answer(id: id,
                                        expression: expression,
                                        content: content,
                                        timestamp: timestamp)
                    return answer
                }
                
            } catch {
                print("유저가 대답한 질문 가져오기 실패: \(error.localizedDescription)")
            }
        }
        return nil
    }
}
