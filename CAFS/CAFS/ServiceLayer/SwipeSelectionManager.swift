import Foundation
import FirebaseStorage

protocol ISwipeSelectionManager {
    func nextSwipe(currentUser: PersonalData, _ completion: @escaping (Result<PersonalData, Error>) -> Void)
}

class SwipeSelectionManager: ISwipeSelectionManager {
    enum SwipeSelectionManagerError: Error {
        case documentDataMissing
        case emptyQueue
    }
    
    private let firestoreManager: IFirestoreManager
    private static let collection = "users"
    private static let statusField = "status"
    private var isInit = false
    private var ids: [String] = []
    
    init(firestoreManager: IFirestoreManager) {
        self.firestoreManager = firestoreManager
    }
    
    func getSwipeIDs(status: String, _ completion: @escaping (Result<[String], Error>) -> Void) {
        let statusNeeded = status == "student" ? "teacher" : "student"
        firestoreManager.getDocuments(collection: Self.collection, field: Self.statusField, equalTo: statusNeeded) { result in
            switch result {
            case .success(let querySnapshot):
                for document in querySnapshot.documents {
                    self.ids.append(document.documentID)
                }
                completion(.success(self.ids))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func getUserData(id : String, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        firestoreManager.getDocument(collection: Self.collection, id: id)  { result in
            switch result {
            case .success(let documentSnapshot):
                do {
                    if let personalData = try documentSnapshot.data(as: PersonalData.self) {
                        completion(.success(personalData))
                    } else {
                        completion(.failure(SwipeSelectionManagerError.documentDataMissing))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func nextSwipe(currentUser: PersonalData, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        if !self.isInit {
            DispatchQueue.main.sync {
                getSwipeIDs(status: currentUser.status) { result in
                    switch result {
                    case .failure(_):
                        print("Failed getIDs")
                    case .success(_):
                        print("Success getIDs")
                    }
                }
                self.isInit = true
            }
        }
        DispatchQueue.main.sync {
            if !ids.isEmpty {
                getUserData(id: ids[0], completion)
                ids.removeFirst()
            } else {
                completion(.failure(SwipeSelectionManagerError.emptyQueue))
            }
        }
    }
}
