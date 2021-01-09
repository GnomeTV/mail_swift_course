import Foundation
import FirebaseStorage

protocol ISelectionViewModel {
    func getCurrentUserInfo() -> PersonalData?
    func updateCurrentUserInfo(personalData: PersonalData, _ completion: @escaping (_ success: Bool) -> Void)
    func getSwipeUserAvatar(user: PersonalData, _ completion: @escaping (Result<UIImage, Error>) -> Void)
    func nextSwipe(currentUser: PersonalData, _ completion: @escaping (Result<PersonalData, Error>) -> Void)
}

class SelectionViewModel: ISelectionViewModel {
    private let userManager: IUserManager
    private let userDefaultsManager: IUserDeafaultsManager
    private let swipeSelectionManager: ISwipeSelectionManager
    
    init(userManager: IUserManager, userDefaultsManager: IUserDeafaultsManager, swipeSelectionManager: ISwipeSelectionManager) {
        self.userManager = userManager
        self.userDefaultsManager = userDefaultsManager
        self.swipeSelectionManager = swipeSelectionManager
    }
    
    func getCurrentUserInfo() -> PersonalData? {
        return userDefaultsManager.getUserInfo()
    }
    
    func updateCurrentUserInfo(personalData: PersonalData, _ completion: @escaping (_ success: Bool) -> Void) {
        userDefaultsManager.updateUserInfo(userData: personalData)
        userManager.updateUserData(personalData: personalData) { error in
            DispatchQueue.main.async {
                completion(error == nil)
            }
        }
    }
    
    func getSwipeUserAvatar(user: PersonalData, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        userManager.getImage(user: user, completion)
    }
    
    func nextSwipe(currentUser: PersonalData, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        swipeSelectionManager.nextSwipe(currentUser: currentUser, completion)
    }
}
