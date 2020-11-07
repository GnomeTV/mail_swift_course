import UIKit
import Firebase

protocol IFirestoreManager{
    func addDocument(collection: String, params: [String : Any], _ completion: @escaping (_ error: Error?) -> Void)
    
    func deleteDocument(collection: String, id: String, _ completion: @escaping (_ error: Error?) -> Void)
    
    func editDocument(collection: String, id: String, params: [String : Any], _ completion: @escaping (_ error: Error?) -> Void)
}

class FirestoreManager: IFirestoreManager {

    private let db = Firestore.firestore()
    
    func addDocument(collection: String, params: [String : Any], _ completion: @escaping (_ error: Error?) -> Void){
        let newDocument = db.collection(collection).document()
        newDocument.setData(params, completion: completion)
    }
    
    func deleteDocument(collection: String, id: String, _ completion: @escaping (_ error: Error?) -> Void) {
        db.collection(collection).document(id).delete(completion: completion)
    }
    
    func editDocument(collection: String, id: String, params: [String : Any], _ completion: @escaping (_ error: Error?) -> Void) {
        var newParams = params
        newParams["id"] = id
        db.collection(collection).document(id).setData(newParams, completion: completion)
    }
}
