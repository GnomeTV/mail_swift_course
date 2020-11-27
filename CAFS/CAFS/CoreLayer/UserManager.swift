import Foundation

class UserManager : FirestoreManager {
    let collection = "users"
    
    func addNewUser(personalData : PersonalData, _ completion: @escaping (_ error: Error?) -> Void) {
        let id = personalData.getId()
        super.addNewDocument(collection: collection, id: id, data: personalData, completion)
    }
    
    func getUserData(id : String, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        super.getDocument(collection: collection, id: id)  { result in
            switch result {
            case .success(let documentSnapshot):
                do {
                    let pData = try documentSnapshot.data(as: PersonalData.self)
                    completion(Result.success(pData!))
                } catch {
                    completion(Result.failure(error))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func isUserExist(id : String, _ completion: @escaping (_ result: Bool) -> Void) {
        do {
            getUserData(id: id) { result in
                print("Check user")
                switch result {
                case .success(_):
                    print("User exists")
                    completion(true)
                case .failure(_):
                    print("User not exists")
                    completion(false)
                }
            }
        }
    }
}
