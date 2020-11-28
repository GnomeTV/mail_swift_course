import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let shared = UIApplication.shared.delegate as! AppDelegate
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        let navigationController = MainNavigationController(rootViewController: LoginViewController())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    
        self.window = window
        return true
    }

}
