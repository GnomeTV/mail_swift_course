import Foundation

protocol IProfileViewModel {
    
}

class ProfileViewModel: IProfileViewModel {
    private let userManager: IUserManager
    
    init(userManager: IUserManager) {
        self.userManager = userManager
    }


}
