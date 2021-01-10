import UIKit

class MatchViewController: UIViewController {
    private let matchesTabelView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(matchesTabelView)
    }
    
}
