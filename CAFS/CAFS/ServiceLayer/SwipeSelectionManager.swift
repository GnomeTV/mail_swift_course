import Foundation
import FirebaseStorage

protocol ISwipeSelectionManager {
    func nextSwipe(currentUser: PersonalData, _ completion: @escaping (Result<PersonalData, Error>) -> Void)
    func resetSwipeQueue()
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
        let statusNeeded = status == "Студент" ? "Преподаватель" : "Студент"
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
    
    func initIDs(status: String, _ completion: @escaping (Result<[String], Error>) -> Void) {
        if !self.isInit {
            getSwipeIDs(status: status) { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let IDs):
                    completion(.success(IDs))
                    self.isInit = true
                }
            }
        } else {
            completion(.success(self.ids))
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
        initIDs(status: currentUser.status) { [self] result in
            switch result {
            case .success(_):
                if !ids.isEmpty {
                    getUserData(id: ids[0], completion)
                    ids.removeFirst()
                } else {
                    completion(.failure(SwipeSelectionManagerError.emptyQueue))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func resetSwipeQueue() {
        isInit = false
        ids = []
    }
}
