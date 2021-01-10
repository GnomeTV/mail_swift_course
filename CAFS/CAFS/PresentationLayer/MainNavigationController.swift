import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setNavigationBarHidden(true, animated: false)
    }
    

}
