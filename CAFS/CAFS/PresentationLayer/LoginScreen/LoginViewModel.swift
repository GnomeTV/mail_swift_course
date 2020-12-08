import Foundation

protocol ILoginViewModel {
    func userExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void)
    func getUserData(email: String, _ completion: @escaping (Result<PersonalData, Error>) -> Void)
}

class LoginViewModel: ILoginViewModel {
    private let userManager: IUserManager
    
    init(userManager: IUserManager) {
        self.userManager = userManager
    }

    
    func userExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void) {
        userManager.userExist(email: email, completion)
    }
    
    func getUserData(email: String, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        let id = email.genHash()
        userManager.getUserData(id: id, completion)
    }
}
