import Foundation
import FirebaseStorage

protocol IProfileViewModel {
    func addUserAvatar(user: PersonalData, avatar: Data, _ completion: @escaping (Result< (StorageUploadTask, URL), Error>) -> Void)
    func getUserAvatar(user: PersonalData, _ completion: @escaping (Result<UIImage, Error>) -> Void)
    func getUserInfoFromCache() -> PersonalData?
    func getUserInfoFromServer(userData: PersonalData, _ completion: @escaping (Result<PersonalData, Error>) -> Void)
    func updateUserInfo(personalData: PersonalData, _ completion: @escaping (_ success: Bool) -> Void)
}

class ProfileViewModel: IProfileViewModel {
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
    
    func getUserInfoFromCache() -> PersonalData? {
        return userDefaultsManager.getUserInfo()
    }
    
    func getUserInfoFromServer(userData: PersonalData, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        let id = userData.email.genHash()
        userManager.getUserData(id: id, completion)
    }
    
    func updateUserInfo(personalData: PersonalData, _ completion: @escaping (_ success: Bool) -> Void) {
        userDefaultsManager.updateUserInfo(userData: personalData)
        userManager.updateUserData(personalData: personalData) { error in
            DispatchQueue.main.async {
                completion(error == nil)
            }
        }
    }
}
