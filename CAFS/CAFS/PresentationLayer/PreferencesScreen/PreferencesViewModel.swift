import Foundation

protocol IPreferencesViewModel {
    func clearUser()
}

class PreferencesViewModel: IPreferencesViewModel {
    private let userManager: IUserManager
    private let userDefaultsManager: IUserDeafaultsManager
    private let swipeSelectionManager: ISwipeSelectionManager
    
    init(userManager: IUserManager, userDefaultsManager: IUserDeafaultsManager, swipeSelectionManager: ISwipeSelectionManager) {
        self.userManager = userManager
        self.userDefaultsManager = userDefaultsManager
        self.swipeSelectionManager = swipeSelectionManager
    }
    
    func clearUser() {
        userDefaultsManager.clearUserInfo()
        swipeSelectionManager.resetSwipeQueue()
    }
}
