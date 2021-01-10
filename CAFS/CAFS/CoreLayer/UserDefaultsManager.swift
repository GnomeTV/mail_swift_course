import Foundation

protocol IUserDeafaultsManager {
    func updateUserInfo(userData: PersonalData)
    
    func getUserInfo() -> PersonalData?
    
    func clearUserInfo()
}

class UserDefaultsManager: IUserDeafaultsManager {
    lazy var userInfo = UserDefaults.standard
    let keyUserInfo = "userInfo"
    let keyUserAvatar = "userAvatar"
    
    func updateUserInfo(userData: PersonalData) {
        userInfo.set(true, forKey: "isLogged")
        let storageData = try? JSONEncoder().encode(userData)
        userInfo.set(storageData, forKey: keyUserInfo)
    }
    
    func updateUserAvatar(avatar: Data) {
        userInfo.set(avatar, forKey: keyUserAvatar)
    }
    
    func getUserInfo() -> PersonalData? {
        if let rawData = userInfo.data(forKey: keyUserInfo) {
            let userData = try? JSONDecoder().decode(PersonalData.self, from: rawData)
            return userData
        } else {
            return nil
        }
    }
    
    func getUserAvatar() -> Data? {
        if let userAvatar = userInfo.data(forKey: keyUserAvatar) {
            return userAvatar
        } else {
            return nil
        }
    }
    
    func clearUserInfo() {
        let domain = Bundle.main.bundleIdentifier!
        userInfo.removePersistentDomain(forName: domain)
        userInfo.synchronize()
    }
}
