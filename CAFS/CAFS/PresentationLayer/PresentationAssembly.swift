import Foundation

protocol IPresentationAssembly {
    var loginViewModel: ILoginViewModel { get }
    var registrationViewModel: IRegistrationViewModel { get }
    var userData: PersonalData { get set }
}

final class PresentationAssembly: IPresentationAssembly {
    
    lazy var loginViewModel: ILoginViewModel = {
        LoginViewModel(userManager: servicesAssembly.userManager, personalData: servicesAssembly.userPersonalData)
    }()
    
    lazy var registrationViewModel: IRegistrationViewModel = {
        RegistrationViewModel(userManager: servicesAssembly.userManager, personalData: servicesAssembly.userPersonalData)
    }()
    
    lazy var userData: PersonalData = servicesAssembly.userPersonalData
    
    private let servicesAssembly: IServicesAssembly
    
    init(servicesAssembly: IServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
}
