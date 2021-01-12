import Foundation

protocol ILoginViewModel {
    func isUserExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void)
    func getUserData(email: String, _ completion: @escaping (Result<PersonalData, Error>) -> Void)
    func initUserCache(userData: PersonalData)
}

class LoginViewModel: ILoginViewModel {
    private let userManager: IUserManager
    private let userDefaultsManager: IUserDeafaultsManager
    
    init(userManager: IUserManager, userDefaultsManager: IUserDeafaultsManager) {
        self.userManager = userManager
        self.userDefaultsManager = userDefaultsManager
    }
    
    func isUserExist(email: String, _ completion: @escaping (_ isUserExist: Bool) -> Void) {
        userManager.isUserExist(email: email, completion)
    }
    
    func getUserData(email: String, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        let id = email.genHash()
        userManager.getUserData(id: id, completion)
    }
    
    func initUserCache(userData: PersonalData) {
        userManager.updateUserCache(userData: userData)
    }
}
