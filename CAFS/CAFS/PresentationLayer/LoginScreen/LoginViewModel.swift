import Foundation

protocol ILoginViewModel {
    func userExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void)
    func updateUserPersonalData(personalData: PersonalData)
    var userPersonalData: PersonalData { get set }
}

class LoginViewModel: ILoginViewModel {
    private let userManager: IUserManager
    internal var userPersonalData: PersonalData
    
    init(userManager: IUserManager, personalData: PersonalData) {
        self.userManager = userManager
        self.userPersonalData = personalData
    }

    func userExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void) {
        userManager.userExist(email: email, completion)
    }
    
    func updateUserPersonalData(personalData: PersonalData) {
        self.userPersonalData = personalData
    }
}
