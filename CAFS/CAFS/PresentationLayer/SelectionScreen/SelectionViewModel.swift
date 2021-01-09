import Foundation
import FirebaseStorage

protocol ISelectionViewModel {
    func addUserAvatar(user: PersonalData, avatar: Data, _ completion: @escaping (Result< (StorageUploadTask, URL), Error>) -> Void)
    func getUserAvatar(user: PersonalData, _ completion: @escaping (Result<UIImage, Error>) -> Void)
    func getUserInfo() -> PersonalData?
    func updateUserInfo(personalData: PersonalData)
}

class SelectionViewModel: ISelectionViewModel {
    private let userManager: IUserManager
    private let userDefaultsManager: IUserDeafaultsManager
    
    init(userManager: IUserManager, userDefaultsManager: IUserDeafaultsManager) {
        self.userManager = userManager
        self.userDefaultsManager = userDefaultsManager
    }
    
    func addUserAvatar(user: PersonalData, avatar: Data, _ completion: @escaping (Result< (StorageUploadTask, URL), Error>) -> Void) {
        userManager.addImage(user: user, avatar: avatar, completion)
    }
    
    func getUserAvatar(user: PersonalData, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        userManager.getImage(user: user, completion)
    }
    
    func getUserInfo() -> PersonalData? {
        return userDefaultsManager.getUserInfo()
    }
    
    func updateUserInfo(personalData: PersonalData) {
        userDefaultsManager.updateUserInfo(userData: personalData)
    }
}
