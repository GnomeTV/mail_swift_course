import Foundation

protocol IPresentationAssembly {
    var loginViewModel: ILoginViewModel { get }
    var registrationViewModel: IRegistrationViewModel { get }
}

final class PresentationAssembly: IPresentationAssembly {
    
    lazy var loginViewModel: ILoginViewModel = { LoginViewModel() }()
    lazy var registrationViewModel: IRegistrationViewModel = {
        RegistrationViewModel(userManager: servicesAssembly.userManager)
    }()
    
    private let servicesAssembly: IServicesAssembly
    
    init(servicesAssembly: IServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
}
