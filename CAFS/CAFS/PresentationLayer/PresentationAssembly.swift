import Foundation

protocol IPresentationAssembly {
    var loginViewModel: ILoginViewModel { get }
    var registrationViewModel: IRegistrationViewModel { get }
    var profileViewModel: IProfileViewModel { get }
    var preferencesViewModel: IPreferencesViewModel { get }
}

final class PresentationAssembly: IPresentationAssembly {
    
    lazy var loginViewModel: ILoginViewModel = {
        LoginViewModel(userManager: servicesAssembly.userManager, userDefaultsManager: servicesAssembly.userDefaultsManager)
    }()
    
    lazy var registrationViewModel: IRegistrationViewModel = {
        RegistrationViewModel(userManager: servicesAssembly.userManager, userDefaultsManager: servicesAssembly.userDefaultsManager)
    }()
    
    lazy var profileViewModel: IProfileViewModel = {
        ProfileViewModel(userManager: servicesAssembly.userManager, userDefaultsManager: servicesAssembly.userDefaultsManager)
    }()
    
    lazy var preferencesViewModel: IPreferencesViewModel = {
        PreferencesViewModel(userManager: servicesAssembly.userManager, userDefaultsManager: servicesAssembly.userDefaultsManager)
    }()
    
    private let servicesAssembly: IServicesAssembly
    
    init(servicesAssembly: IServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
}
