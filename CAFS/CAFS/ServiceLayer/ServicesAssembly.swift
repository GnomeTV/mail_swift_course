import Foundation

protocol IServicesAssembly {
    var alertService : IAlertService { get }
}

final class ServicesAssembly: IServicesAssembly {
    
    let alertService: IAlertService = AlertService() as! IAlertService
    
    private let coreAssembly: ICoreAssembly
    
    init(coreAssembly: ICoreAssembly) {
        self.coreAssembly = coreAssembly
    }
}
