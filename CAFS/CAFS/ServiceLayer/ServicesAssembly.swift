import Foundation

protocol IServicesAssembly {
    var userManager: IUserManager { get }
    var userDefaultsManager: IUserDeafaultsManager { get }
}

final class ServicesAssembly: IServicesAssembly {
    
    lazy var userManager: IUserManager = {
        UserManager(firestoreManager: coreAssembly.firestoreManager)
    }()
    
    lazy var userDefaultsManager: IUserDeafaultsManager = {
        UserDefaultsManager()
    }()
    
    private let coreAssembly: ICoreAssembly
    
    init(coreAssembly: ICoreAssembly) {
        self.coreAssembly = coreAssembly
    }
}
