import Foundation

protocol IUserManager {
    func addNewUser(personalData : PersonalData, _ completion: @escaping (_ error: Error?) -> Void)
    
    func getUserData(id : String, _ completion: @escaping (Result<PersonalData, Error>) -> Void)
    
    func userExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void)
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
    
    func updateUserAvatar(personalData : PersonalData, _ completion: @escaping (_ error: Error?) -> Void) {
        let id = personalData.email.genHash()
        firestoreManager.editObject(personalData, inCollection: Self.collection, withId: id, completion)
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
}
