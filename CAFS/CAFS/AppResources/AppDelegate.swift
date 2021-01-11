import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let shared = UIApplication.shared.delegate as! AppDelegate
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        
        if UserDefaults.standard.bool(forKey: "isDarkTheme") {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        }
        
        if UserDefaults.standard.bool(forKey: "isLogged") {
            let navigationController = MainNavigationController(rootViewController: MainTabBarController())
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        } else {
            let navigationController = MainNavigationController(rootViewController: LoginViewController())
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        
        self.window = window
        return true
    }

}
