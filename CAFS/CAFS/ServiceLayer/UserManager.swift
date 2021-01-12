import Foundation
import FirebaseStorage

protocol IUserManager {
    func addNewUser(personalData : PersonalData, _ completion: @escaping (_ error: Error?) -> Void)
    
    func getUserData(id : String, _ completion: @escaping (Result<PersonalData, Error>) -> Void)
    
    func userExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void)
    
    func updateUserData(personalData : PersonalData, _ completion: @escaping (_ error: Error?) -> Void)
    
    func addImage(user: PersonalData, avatar: Data, _ completion: @escaping (Result< (StorageUploadTask, URL), Error>) -> Void)
    
    func getImage(user: PersonalData, _ completion: @escaping (Result<UIImage, Error>) -> Void)
}

class UserManager : IUserManager {
    
    enum UserManagerError: Error {
        case documentDataIsMissing
    }
    
    private static let collection = "users"
    
    private let firestoreManager: IFirestoreManager
    
    init(firestoreManager: IFirestoreManager) {
        self.firestoreManager = firestoreManager
    }
    
    func addNewUser(personalData : PersonalData, _ completion: @escaping (_ error: Error?) -> Void) {
        let id = personalData.email.genHash()
        firestoreManager.addNewDocument(collection: Self.collection, id: id, data: personalData, completion)
    }
    
    func updateUserData(personalData : PersonalData, _ completion: @escaping (_ error: Error?) -> Void) {
        let id = personalData.email.genHash()
        firestoreManager.updateDocument(collection: Self.collection, id: id, data: personalData, completion)
    }
    
    func getUserData(id : String, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        firestoreManager.getDocument(collection: Self.collection, id: id)  { result in
            switch result {
            case .success(let documentSnapshot):
                do {
                    if let personalData = try documentSnapshot.data(as: PersonalData.self) {
                        completion(.success(personalData))
                    } else {
                        completion(.failure(UserManagerError.documentDataIsMissing))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func userExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void) {
        do {
            let id = email.genHash()
            getUserData(id: id) { result in
                switch result {
                case .success(_):
                    completion(true)
                case .failure(_):
                    completion(false)
                }
            }
        }
    }
    
    func addImage(user: PersonalData, avatar: Data, _ completion: @escaping (Result< (StorageUploadTask, URL), Error>) -> Void) {
        let path = "users/"+user.email.genHash()+"/"
        let imageName = "avatar.png"
        firestoreManager.addStorageObject(path: path, name: imageName, data: avatar, completion)
    }
    
    func getImage(user: PersonalData, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        let path = "users/"+user.email.genHash()+"/"
        let imageName = "avatar.png"
        firestoreManager.getStorageObject(path: path, name: imageName) { result in
            switch result {
            case .success(let data):
                completion(.success(UIImage(data: data)!))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
