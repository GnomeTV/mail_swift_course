import Foundation
import FirebaseStorage

protocol IProfileViewModel {
    /*func addUserAvatar(user: PersonalData, avatar: Data, _ completion: @escaping (Result< (StorageUploadTask, URL), Error>) -> Void)
    func getUserAvatar(user: PersonalData, _ completion: @escaping (Result<UIImage, Error>) -> Void)
    func getUserInfoFromServer(userData: PersonalData, _ completion: @escaping (Result<PersonalData, Error>) -> Void)
    func updateUserInfoInCache(personalData: PersonalData)
    func updateUserInfo(personalData: PersonalData, _ completion: @escaping (_ success: Bool) -> Void)*/
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
    
    /*func addUserAvatar(user: PersonalData, avatar: Data, _ completion: @escaping (Result< (StorageUploadTask, URL), Error>) -> Void) {
        //userManager.addImage(user: user, avatar: avatar, completion)
    }
    
    func getUserAvatar(user: PersonalData, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        //userManager.getImage(user: user, completion)
    }
    
    func getUserInfoFromServer(userData: PersonalData, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        let id = userData.email.genHash()
        //userManager.getUserData(id: id, completion)
    }
    
    func updateUserInfoInCache(personalData: PersonalData) {
        userDefaultsManager.updateUserInfo(userData: personalData)
    }
    
    func updateUserInfo(personalData: PersonalData, _ completion: @escaping (_ success: Bool) -> Void) {
        userDefaultsManager.updateUserInfo(userData: personalData)
        userManager.updateUserData(personalData: personalData) { error in
            DispatchQueue.main.async {
                completion(error == nil)
            }
        }
    }*/
    
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
