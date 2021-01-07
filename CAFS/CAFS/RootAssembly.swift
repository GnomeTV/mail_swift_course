import Foundation

protocol IRootAssembly {
    var presentationAssembly: IPresentationAssembly { get }
}

final class RootAssembly: IRootAssembly {
    
    // MARK: - Public properties
    static let shared = RootAssembly()
    let presentationAssembly: IPresentationAssembly
    
    // MARK: - Private properties
    private let servicesAssembly: IServicesAssembly
    private let coreAssembly: ICoreAssembly
    
    // MARK: - Initializer
    init() {
        coreAssembly = CoreAssembly()
        servicesAssembly = ServicesAssembly(coreAssembly: coreAssembly)
        presentationAssembly = PresentationAssembly(servicesAssembly: servicesAssembly)
    }
}
