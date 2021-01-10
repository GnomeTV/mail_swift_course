import UIKit


class MatchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
        print(model.matchesIDs.count)
        return model.matchesIDs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        let matchUserID = model.matchesIDs[indexPath.row]
        print(model.matchesIDs)
        cell.profileImageView.image = UIImage(named: "profile_icon")
        model.getUserInfoFromServer(id: matchUserID) { result in
            switch result {
            case .success(let matchUserData):
                print(matchUserData.email)
                self.model.getUserAvatar(user: matchUserData) { result in
                    switch result {
                    case .success(let matchUserAvatar):
                        cell.match = matchUserData
                        cell.profileImageView.image = matchUserAvatar
                    case .failure(_):
                        cell.profileImageView.image = UIImage(named: "profile_icon")
                    }
                }
            case .failure(_):
                print("Error load user")
            }
        }
        return cell
    }
    
}

