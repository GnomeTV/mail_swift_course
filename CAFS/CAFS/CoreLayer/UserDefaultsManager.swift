import Foundation

protocol IUserDeafaultsManager {
    func updateUserInfo(userData: PersonalData)
    
    func getUserInfo() -> PersonalData?
}

class UserDefaultsManager: IUserDeafaultsManager {
    lazy var userInfo = UserDefaults.standard
    let key = "userInfo"
    
    func updateUserInfo(userData: PersonalData) {
        let storageData = try? JSONEncoder().encode(userData)
        userInfo.set(storageData, forKey: key)
    }
    
    func getUserInfo() -> PersonalData? {
        if let rawData = userInfo.data(forKey: key) {
            let userData = try? JSONDecoder().decode(PersonalData.self, from: rawData)
            return userData
        } else {
            return nil
        }
    }
}
