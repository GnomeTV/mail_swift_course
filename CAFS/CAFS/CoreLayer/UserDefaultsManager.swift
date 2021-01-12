import Foundation

protocol IUserDeafaultsManager {
    func initUser(userData: PersonalData)
    
    func updateUserInfo(userData: PersonalData)
    
    func updateUserAvatar(avatar: Data?)
    
    func isLogged() -> Bool
    
    func getUserInfo() -> PersonalData?
    
    func getUserAvatar() -> Data?
    
    func isDarkTheme() -> Bool
    
    func setTheme(isDarkTheme: Bool)
    
    func clearUserInfo()
}

class UserDefaultsManager: IUserDeafaultsManager {
    enum UserDefaultsKeys {
        static let keyIsLogged = "isLogged"
        static let keyUserInfo = "userInfo"
        static let keyUserAvatar = "userAvatar"
        static let keyIsDarkTheme = "isDarkTheme"
    }
    lazy var userInfo = UserDefaults.standard
    
    func initUser(userData: PersonalData) {
        updateUserInfo(userData: userData)
    }
    
    func updateUserInfo(userData: PersonalData) {
        userInfo.set(true, forKey: UserDefaultsKeys.keyIsLogged)
        let storageData = try? JSONEncoder().encode(userData)
        userInfo.set(storageData, forKey: UserDefaultsKeys.keyUserInfo)
    }
    
    func isLogged() -> Bool {
        return userInfo.bool(forKey: "isLogged")
    }
    
    func updateUserAvatar(avatar: Data?) {
        print("Adding avatar hash: \(avatar?.hashValue ?? 0)")
        userInfo.set(avatar, forKey: UserDefaultsKeys.keyUserAvatar)
    }
    
    func getUserInfo() -> PersonalData? {
        if let rawData = userInfo.data(forKey: UserDefaultsKeys.keyUserInfo) {
            let userData = try? JSONDecoder().decode(PersonalData.self, from: rawData)
            return userData
        } else {
            return nil
        }
    }
    
    func getUserAvatar() -> Data? {
        if let userAvatar = userInfo.data(forKey: UserDefaultsKeys.keyUserAvatar) {
            print("getUserAvatarFromCache Success")
            return userAvatar
        } else {
            print("getUserAvatarFromCache Error")
            return nil
        }
    }
    
    func isDarkTheme() -> Bool {
        return userInfo.bool(forKey: UserDefaultsKeys.keyIsDarkTheme)
    }
    
    func setTheme(isDarkTheme: Bool) {
        userInfo.set(isDarkTheme, forKey: UserDefaultsKeys.keyIsDarkTheme)
    }
    
    func clearUserInfo() {
        let domain = Bundle.main.bundleIdentifier!
        userInfo.removePersistentDomain(forName: domain)
        userInfo.synchronize()
    }
}
