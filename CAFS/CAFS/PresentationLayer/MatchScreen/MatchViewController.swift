import UIKit


class MatchViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    private var matches: [(matchUser: PersonalData?, matchUserAvatar: UIImage?)] = []
    private let matchTabelView = UITableView()
    private let model = viewModels.matchViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(matchTabelView)
        
        matchTabelView.translatesAutoresizingMaskIntoConstraints = false
        matchTabelView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        matchTabelView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        matchTabelView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        matchTabelView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true

        matchTabelView.dataSource = self
        matchTabelView.delegate = self
        
        matchTabelView.register(ContactTableViewCell.self, forCellReuseIdentifier: "contactCell")
        
        updateMatches()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateMatches()
    }
    
    func updateMatches() {
        model.getMatches()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        updateMatches()
        matches = model.matches
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        if let userData = matches[indexPath.row].matchUser {
            cell.match = userData
            cell.profileImageView.image = matches[indexPath.row].matchUserAvatar ?? UIImage(named: "profile_icon")
        }
        return cell
    }
    
}

