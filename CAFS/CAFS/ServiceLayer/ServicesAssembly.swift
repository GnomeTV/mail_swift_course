import Foundation

protocol IServicesAssembly {
    var userManager: IUserManager { get }
    var userPersonalData: PersonalData { get set }
}

final class ServicesAssembly: IServicesAssembly {
    
    lazy var userManager: IUserManager = {
        UserManager(firestoreManager: coreAssembly.firestoreManager)
    }()
    
    lazy var userPersonalData: PersonalData = coreAssembly.userPersonalData
    
    private let coreAssembly: ICoreAssembly
    
    init(coreAssembly: ICoreAssembly) {
        self.coreAssembly = coreAssembly
    }
}
