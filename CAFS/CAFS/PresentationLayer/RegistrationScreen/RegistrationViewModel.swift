import Foundation

protocol IRegistrationViewModel {
    func userExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void)
    func addNewUser(personalData : PersonalData, _ completion: @escaping (_ success: Bool) -> Void)
}

class RegistrationViewModel: IRegistrationViewModel {
    private let userManager: IUserManager
    
    init(userManager: IUserManager) {
        self.userManager = userManager
    }
    
    func userExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void) {
        userManager.userExist(email: email, completion)
    }
    
    func addNewUser(personalData : PersonalData, _ completion: @escaping (_ success: Bool) -> Void) {
        userManager.addNewUser(personalData: personalData) { error in
            DispatchQueue.main.async {
                completion(error == nil)
            }
        }
    }
}
