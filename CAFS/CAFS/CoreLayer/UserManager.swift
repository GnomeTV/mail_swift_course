import Foundation

class UserManager : FirestoreManager {
    let collection = "users"
    
    func addNewUser(personalData : PersonalData, _ completion: @escaping (_ error: Error?) -> Void) {
        let id = personalData.getId()
        super.addNewDocument(collection: collection, id: id, data: personalData, completion)
    }
    
    func getUserData(id : String, _ completion: @escaping (_ userData: PersonalData?, _ error: Error?) -> Void) {
        super.getDocument(collection: collection, id: id)  { uData, err in
            if let err = err {
                completion(nil, err)
            } else {
                do {
                    let pData = try uData?.data(as: PersonalData.self)
                    completion(pData, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
    }
    
    func isUserExist(id : String, _ completion: @escaping (_ result: Bool?) -> Void) {
        do {
            getUserData(id: id) { pData, err in
                print("Check user")
                if pData != nil {
                    print("User exists")
                    completion(true)
                } else {
                    completion(nil)
                }
            }
            
        }
    }
}
