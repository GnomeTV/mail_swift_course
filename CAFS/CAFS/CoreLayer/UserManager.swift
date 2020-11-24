import Foundation

class UserManager : FirestoreManager {
    
    func addNewUser(personalData : PersonalData, _ completion: @escaping (_ error: Error?) -> Void) {
        var pData = personalData
        let collection = "users"
        let id = personalData.getId()
        super.addNewDocument(collection: collection, id: id, data: &pData) { err in
            if let err = err {
                completion(err)
            } else {
                completion(nil)
            }
        }
    }
}
