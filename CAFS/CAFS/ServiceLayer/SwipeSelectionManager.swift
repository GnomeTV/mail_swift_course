import Foundation
import FirebaseStorage

protocol ISwipeSelectionManager {
    func getSwipeIDs(status: String, _ completion: @escaping (Result<[String], Error>) -> Void)
}

class SwipeSelectionManager: ISwipeSelectionManager {
    private let firestoreManager: IFirestoreManager
    private static let collection = "users"
    private static let statusField = "status"
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
}
