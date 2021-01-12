import Foundation
import FirebaseStorage

protocol IProfileViewModel {
    func getUserInfoFromCache() -> PersonalData?
    func getUserAvatarFromCache() -> UIImage?
    func addNewUserAvatarCache(avatar: UIImage)
    func addUpdateListener(userData: PersonalData, _ completion: @escaping (Result<PersonalData, Error>) -> Void)
    func updateAvatarFromServer(userData: PersonalData, _ completion: @escaping (_ isUserExist: UIImage?) -> Void)
    func updateUserCache(userData: PersonalData)
}

class ProfileViewModel: IProfileViewModel {
    private let userManager: IUserManager
    
    init(userManager: IUserManager) {
        self.userManager = userManager
    }
    
    func getUserInfoFromCache() -> PersonalData? {
        return userManager.getUserInfoFromCache()
    }
    
    func getUserAvatarFromCache() -> UIImage? {
        let avatar = userManager.getUserAvatarFromCache()
        return avatar
    }
    
    func addNewUserAvatarCache(avatar: UIImage) {
        userManager.addNewUserAvatarCache(userAvatar: avatar)
    }
    
    func addUpdateListener(userData: PersonalData, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        let email = userData.email
        userManager.initMainListener(email: email, completion)
    }
    
    func updateAvatarFromServer(userData: PersonalData, _ completion: @escaping (_ isUserExist: UIImage?) -> Void) {
        userManager.updateAvatarFromServer(userData: userData, completion)
    }
    
    func updateUserCache(userData: PersonalData) {
        userManager.updateUserCache(userData: userData)
    }
}
