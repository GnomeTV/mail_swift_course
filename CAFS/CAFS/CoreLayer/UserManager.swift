import Foundation

class UserManager : FirestoreManager {
    
    func addNewUser(personalData : PersonalData, _ completion: @escaping (_ error: Error?) -> Void) {
        let collection = "users"
        let id = personalData.getId()
        do {
            try db?.collection(collection).document(id).setData(from: personalData)
            completion(nil)
        } catch {
            completion(error)
        }
    }
}
