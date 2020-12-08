import Foundation

protocol ILoginViewModel {
    func userExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void)
}

class LoginViewModel: ILoginViewModel {
    private let userManager: IUserManager
    
    init(userManager: IUserManager) {
        self.userManager = userManager
    }

    func userExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void) {
        userManager.userExist(email: email, completion)
    }
}
