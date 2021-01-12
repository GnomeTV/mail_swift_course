import UIKit
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

protocol IFirestoreManager {
    func saveObject<Object: Encodable>(_ objectToSave: Object, toCollection collection: String, _ completion: @escaping (_ error: Error?) -> Void)
    
    func addNewDocument<DataType: Codable>(collection : String, id : String, data: DataType, _ completion: @escaping (_ error: Error?) -> Void)
    
    func updateDocument<DataType: Codable>(collection : String, id : String, data: DataType, _ completion: @escaping (_ error: Error?) -> Void)
    
    func deleteDocument(collection: String, id: String, _ completion: @escaping (_ error: Error?) -> Void)
    
    func getDocument(collection: String, id: String, _ completion: @escaping (Result<DocumentSnapshot, Error>) -> Void)
    
    func getDocuments(collection: String, field: String, equalTo: String, _ completion: @escaping (Result<QuerySnapshot, Error>) -> Void)
    
    func addStorageObject(path: String, name: String,  data: Data, _ completion: @escaping (Result< (StorageUploadTask, URL), Error>) -> Void)
    
    func getStorageObject(path: String, name: String, _ completion: @escaping (Result<Data, Error>) -> Void)
}

class FirestoreManager: IFirestoreManager {
    
    enum FirestoreManagerError: Error {
        case documentMissing
        case uploadMissing
        case downloadMissing
    }
    
    private let db: Firestore
    private let storage: Storage
    
    init() {
        FirebaseApp.configure()
        db = Firestore.firestore()
        storage = Storage.storage()
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
    
    func addNewDocument<DataType: Codable>(collection : String, id : String, data: DataType, _ completion: @escaping (_ error: Error?) -> Void) {
        do {
            try db.collection(collection).document(id).setData(from: data)
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    func updateDocument<DataType: Codable>(collection : String, id : String, data: DataType, _ completion: @escaping (_ error: Error?) -> Void) {
        addNewDocument(collection: collection, id: id, data: data, completion)
    }
    
    func deleteDocument(collection: String, id: String, _ completion: @escaping (_ error: Error?) -> Void) {
        db.collection(collection).document(id).delete(completion: completion)
    }
    
    func getDocument(collection: String, id: String, _ completion: @escaping (Result<DocumentSnapshot, Error>) -> Void) {
        db.collection(collection).document(id).getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let document = document, document.exists {
                completion(.success(document))
            } else {
                completion(.failure(FirestoreManagerError.documentMissing))
            }
        }
    }
    
    func getDocuments(collection: String, field: String, equalTo: String, _ completion: @escaping (Result<QuerySnapshot, Error>) -> Void) {
        db.collection(collection).whereField(field, isEqualTo: equalTo).getDocuments() { (querySnapshot, err) in
            if let err = err {
                completion(.failure(err))
            } else {
                completion(.success(querySnapshot!))
            }
        }
    }
    
    func addStorageObject(path: String, name: String,  data: Data, _ completion: @escaping (Result< (StorageUploadTask, URL), Error>) -> Void) {
        let ref = storage.reference().child(path+name)
        let uploadTask = ref.putData(data, metadata: nil) { metadata, error in
            if error != nil {
                completion(.failure(FirestoreManagerError.uploadMissing))
                return
            }
        }
        ref.downloadURL { (url, error) in
            if let downloadURL = url {
                completion(.success((uploadTask, downloadURL)))
            } else {
                completion(.failure(FirestoreManagerError.uploadMissing))
            }
        }
    }
    
    func getStorageObject(path: String, name: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        let ref = storage.reference().child(path+name)
        ref.getData(maxSize: 100 * 1024 * 1024) { data, error in
            if error != nil {
                completion(.failure(FirestoreManagerError.downloadMissing))
            } else {
                completion(.success(data!))
            }
        }
    }
}
