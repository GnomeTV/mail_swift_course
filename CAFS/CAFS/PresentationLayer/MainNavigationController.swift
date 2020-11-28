//
//  MainNavigationController.swift
//  CAFS
//
//  Created by Павел Травкин on 12.11.2020.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setNavigationBarHidden(true, animated: false)
    }
    

}
