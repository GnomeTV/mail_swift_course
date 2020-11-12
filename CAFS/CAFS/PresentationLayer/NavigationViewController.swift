//
//  NavigationViewController.swift
//  CAFS
//
//  Created by Павел Травкин on 11.11.2020.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setNavigationBarHidden(true, animated: false)
    }
    

   
}
