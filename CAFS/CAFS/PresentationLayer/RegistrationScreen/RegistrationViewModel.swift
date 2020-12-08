import Foundation

protocol IRegistrationViewModel {
    func userExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void)
    func addNewUser(personalData : PersonalData, _ completion: @escaping (_ success: Bool) -> Void)
    func updateUserPersonalData(personalData: PersonalData)
    var userPersonalData: PersonalData { get set }
}

class RegistrationViewModel: IRegistrationViewModel {
    internal var userPersonalData: PersonalData
    private let userManager: IUserManager
    
    init(userManager: IUserManager, personalData: PersonalData) {
        self.userManager = userManager
        self.userPersonalData = personalData
    }
    
    func updateUserPersonalData(personalData: PersonalData) {
        self.userPersonalData = personalData
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
