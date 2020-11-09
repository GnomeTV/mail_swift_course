import Foundation

protocol IPresentationAssembly {
    var loginViewModel: ILoginViewModel { get }
    // TODO: - Add view models here
}

final class PresentationAssembly: IPresentationAssembly {
    
    var loginViewModel: ILoginViewModel = LoginViewModel()
    
    private let servicesAssembly: IServicesAssembly
    
    init(servicesAssembly: IServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
}
