import Foundation

protocol IPreferencesViewModel {
    func clearUser()
}

class PreferencesViewModel: IPreferencesViewModel {
    private let userManager: IUserManager
    private let userDefaultsManager: IUserDeafaultsManager
    
    init(userManager: IUserManager, userDefaultsManager: IUserDeafaultsManager) {
        self.userManager = userManager
        self.userDefaultsManager = userDefaultsManager
    }
    
    func clearUser() {
        userDefaultsManager.clearUserInfo()
    }
}
