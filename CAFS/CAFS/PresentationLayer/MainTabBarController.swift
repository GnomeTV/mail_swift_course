//
//  MainTabBarController.swift
//  CAFS
//
//  Created by Павел Травкин on 11.11.2020.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().clipsToBounds = true
        
        let profileViewController = MainNavigationController(rootViewController: ProfileViewController())
        profileViewController.tabBarItem.image = UIImage(named: "profile_icon")
       
        let chatViewController = MainNavigationController(rootViewController: ChatViewController())
        chatViewController.tabBarItem.image = UIImage(named: "chat_icon")
      
        let mainScreenViewController = MainNavigationController(rootViewController: MainScreenViewController())
        mainScreenViewController.tabBarItem.image = UIImage(named: "mainscreen_icon")
      
        viewControllers = [mainScreenViewController, chatViewController, profileViewController]
    }

}
