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
        
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        profileViewController.tabBarItem.image = UIImage(named: "profile_icon")
       
        let chatViewController = UINavigationController(rootViewController: ChatViewController())
        chatViewController.tabBarItem.image = UIImage(named: "chat_icon")
      
        let mainScreenViewController = UINavigationController(rootViewController: MainScreenViewController())
        mainScreenViewController.tabBarItem.image = UIImage(named: "mainScreen_icon")
      
        viewControllers = [mainScreenViewController, chatViewController, profileViewController]
    }


}
