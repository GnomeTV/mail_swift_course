import Foundation

protocol IRegistrationViewModel {
    func userExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void)
    func addNewUser(personalData : PersonalData, _ completion: @escaping (_ success: Bool) -> Void)
    func updateUserInfo(personalData: PersonalData)
}

class RegistrationViewModel: IRegistrationViewModel {
    private let userManager: IUserManager
    private let userDefaultsManager: IUserDeafaultsManager
    
    init(userManager: IUserManager, userDefaultsManager: IUserDeafaultsManager) {
        self.userManager = userManager
        self.userDefaultsManager = userDefaultsManager
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
    
    func updateUserInfo(personalData: PersonalData) {
        userDefaultsManager.updateUserInfo(userData: personalData)
    }
}
