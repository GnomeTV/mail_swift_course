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
    
    func getSwipeIDs(currentUser: PersonalData, _ completion: @escaping (Result<[String], Error>) -> Void) {
        let statusNeeded = currentUser.status == "Студент" ? "Преподаватель" : "Студент"
        firestoreManager.getDocuments(collection: Self.collection, field: Self.statusField, equalTo: statusNeeded) { result in
            switch result {
            case .success(let querySnapshot):
                for document in querySnapshot.documents {
                    let idForSwipeQueue = document.documentID
                    if !currentUser.matches.contains(idForSwipeQueue) && !currentUser.swiped.contains(idForSwipeQueue) && !currentUser.declined.contains(idForSwipeQueue) {
                        self.ids.append(idForSwipeQueue)
                    }
                }
                completion(.success(self.ids))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func initIDs(currentUser: PersonalData, _ completion: @escaping (Result<[String], Error>) -> Void) {
        if !self.isInit {
            getSwipeIDs(currentUser: currentUser) { result in
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
        initIDs(currentUser: currentUser) { [self] result in
            switch result {
            case .success(_):
                if !ids.isEmpty {
                    let idx = Int(arc4random())%ids.count
                    getUserData(id: ids[idx], completion)
                    ids.remove(at: idx)
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
