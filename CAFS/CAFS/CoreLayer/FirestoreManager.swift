import UIKit
import Firebase
import FirebaseFirestoreSwift

protocol IFirestoreManager{
    func saveObject<Object: Encodable>(_ objectToSave: Object, toCollection collection: String, _ completion: @escaping (_ error: Error?) -> Void)
    
    func deleteDocument(collection: String, id: String, _ completion: @escaping (_ error: Error?) -> Void)
    
    func editObject<Object: Encodable>(_ objectToEdit: Object, inCollection collection: String, withId id: String, _ completion: @escaping (_ error: Error?) -> Void)
}

class FirestoreManager: IFirestoreManager {

    private let db: Firestore
    
    init() {
        FirebaseApp.configure()
        db = Firestore.firestore()
    }
    
    func saveObject<Object: Encodable>(_ objectToSave: Object, toCollection collection: String, _ completion: @escaping (_ error: Error?) -> Void) {
        let document = db.collection(collection).document()
        do {
            try document.setData(from: objectToSave)
            completion(nil)
        } catch {
            completion(error)
        }
    } 
    
    private func addNewUserDocument(collection: String, id: String, data : PersonalDataDoc, _ completion: @escaping (_ error: Error?) -> Void) {
        do {
            try db.collection(collection).document(id).setData(from: data)
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    func deleteDocument(collection: String, id: String, _ completion: @escaping (_ error: Error?) -> Void) {
        db.collection(collection).document(id).delete(completion: completion)
    }
    
    func findDocument(collection: String, email: String, password: String, _ completion: @escaping (_ error: Error?) -> Void) -> String{
        let id: String = "0"
        /*Поиск id профиля по почте и паролю*/
        
        return id
    }
    
    func addNewUser(personalData : PersonalData) {
        let collection = "users"
        let id = genHash(string: personalData.getEmail())
        self.addNewUserDocument(collection: collection, id: id, data: personalData.getDocForFirebase()) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Success adding document")
            }
        }
        
    }
    func editObject<Object: Encodable>(_ objectToEdit: Object, inCollection collection: String, withId id: String, _ completion: @escaping (_ error: Error?) -> Void) {
        do {
            try db.collection(collection).document(id).setData(from: objectToEdit)
            completion(nil)
        } catch {
            completion(error)
        }
    }
}
