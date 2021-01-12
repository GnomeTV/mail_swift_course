import Foundation

protocol ILoginViewModel {
    func userExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void)
    func getUserData(email: String, _ completion: @escaping (Result<PersonalData, Error>) -> Void)
    func updateUserInfo(personalData: PersonalData)
}

class LoginViewModel: ILoginViewModel {
    private let userManager: IUserManager
    private let userDefaultsManager: IUserDeafaultsManager
    
    init(userManager: IUserManager, userDefaultsManager: IUserDeafaultsManager) {
        self.userManager = userManager
        self.userDefaultsManager = userDefaultsManager
    }

    func userExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void) {
        userManager.userExist(email: email, completion)
    }
    
    func getUserData(email: String, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        let id = email.genHash()
        userManager.getUserData(id: id, completion)
    }
    
    func updateUserInfo(personalData: PersonalData) {
        userDefaultsManager.updateUserInfo(userData: personalData)
    }
}
