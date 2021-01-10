import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().clipsToBounds = true
        
        
        let profileViewController = MainNavigationController(rootViewController: ProfileViewController())
        profileViewController.tabBarItem.image = UIImage(named: "profile_icon")
       
        let chatViewController = MainNavigationController(rootViewController: MatchViewController())
        chatViewController.tabBarItem.image = UIImage(named: "match_icon")
        
        let mainScreenViewController = MainNavigationController(rootViewController: SelectionViewController())
        mainScreenViewController.tabBarItem.image = UIImage(named: "mainscreen_icon")
      
        viewControllers = [mainScreenViewController, chatViewController, profileViewController]
    }

}
