import Foundation

protocol IServicesAssembly {
    var userManager: IUserManager { get }
}

final class ServicesAssembly: IServicesAssembly {
    
    lazy var userManager: IUserManager = {
        UserManager(firestoreManager: coreAssembly.firestoreManager)
    }()
    
    private let coreAssembly: ICoreAssembly
    
    init(coreAssembly: ICoreAssembly) {
        self.coreAssembly = coreAssembly
    }
}
