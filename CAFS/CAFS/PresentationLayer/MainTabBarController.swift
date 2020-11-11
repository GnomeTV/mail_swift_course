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
        
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        profileViewController.tabBarItem.image = UIImage(named: "profile_icon")
        profileViewController.tabBarItem.selectedImage = UIImage(named: "profileSelected_icon")
       
        
        let chatViewController = UINavigationController(rootViewController: ChatViewController())
        chatViewController.tabBarItem.image = UIImage(named: "chat_icon")
        chatViewController.tabBarItem.selectedImage = UIImage(named: "chatSelected_icon")
      
        
        let mainScreenViewController = UINavigationController(rootViewController: MainScreenViewController())
        mainScreenViewController.tabBarItem.image = UIImage(named: "mainScreen_icon")
        mainScreenViewController.tabBarItem.selectedImage = UIImage(named: "mainScreenSelected_icon")
      
        viewControllers = [mainScreenViewController, chatViewController, profileViewController]
    }


}
