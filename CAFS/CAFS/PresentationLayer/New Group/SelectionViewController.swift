import UIKit


class SelectionViewController: UIViewController {
    
    private let screenWidth = UIScreen.main.bounds.width
    
    private let titleLabel = UILabel()
    
    private let profileImageStackView = UIStackView()
    private let profileImageView = UIImageView(image: UIImage(named: "defaultProfilePhoto_image"))
    
    private let personalInfoStackView = UIStackView()
    private let firstnameLabel = UnderlineTextLabel()
    private let lastnameLabel = UnderlineTextLabel()
    private let universityLabel = UnderlineTextLabel()
    private let statusLabel = UnderlineTextLabel()
    
    private let extraInfoStackView = UIStackView()
    private let extraContactLabel = UILabel()
    private let firstWorkNameLabel = UILabel()
    private let secondWorkNameLabel = UILabel()
    private let thirdWorkNameLabel = UILabel()
    
    // MARK: - Insets
    
    private let leftInset: CGFloat = 24.0
    private let rightInset: CGFloat = 24.0
    private let buttonHeight: CGFloat = 48.0
    private let topInsetTextFieldIndicator: CGFloat = 3.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = .white
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwiped(_:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwiped(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private let model = viewModels.selectionViewModel
    
    // MARK: - Private methods
    private func setupViews() {
        setupProfileLabel()
        setupProfileImageStackView()
        setupPersonalInfoStackView()
        setupInfoStackView()
    }
    
    private func setupProfileImageStackView() {
        
        view.addSubview(profileImageStackView)
        profileImageStackView.translatesAutoresizingMaskIntoConstraints = false
        profileImageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        profileImageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenWidth + 200 + leftInset).isActive = true
        profileImageStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 114.0).isActive = true
        profileImageStackView.bottomAnchor.constraint(equalTo: profileImageStackView.topAnchor, constant: 250).isActive = true
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.masksToBounds = true
        
        profileImageStackView.addArrangedSubview(profileImageView)

        
    }
    
    private func setupPersonalInfoStackView() {
        view.addSubview(personalInfoStackView)
    
        personalInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        personalInfoStackView.leadingAnchor.constraint(equalTo: profileImageStackView.trailingAnchor, constant: 10).isActive = true
        personalInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        personalInfoStackView.topAnchor.constraint(equalTo: profileImageStackView.topAnchor).isActive = true
        personalInfoStackView.bottomAnchor.constraint(equalTo: personalInfoStackView.topAnchor, constant: 180).isActive = true
        
        updateSwipe(acceptUser: nil)
        
        personalInfoStackView.addArrangedSubview(firstnameLabel)
        personalInfoStackView.addArrangedSubview(lastnameLabel)
        personalInfoStackView.addArrangedSubview(universityLabel)
        personalInfoStackView.addArrangedSubview(statusLabel)
        personalInfoStackView.axis = .vertical
        personalInfoStackView.spacing = 30.0
        
    }
    
    private func setupProfileLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Свайпалка"
        titleLabel.textColor = UIColor.hseBlue
        titleLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)
        
        titleLabel.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0).isActive = true
        
    }
    
    private func setupInfoStackView() {
        view.addSubview(extraInfoStackView)
        
        extraInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        extraInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        extraInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        extraInfoStackView.topAnchor.constraint(equalTo: personalInfoStackView.bottomAnchor, constant: 20).isActive = true
        extraInfoStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300).isActive = true
        
        extraContactLabel.text = ""
        firstWorkNameLabel.text = ""
        secondWorkNameLabel.text = ""
        thirdWorkNameLabel.text = ""
        
        extraInfoStackView.addArrangedSubview(extraContactLabel)
        extraInfoStackView.addArrangedSubview(firstWorkNameLabel)
        extraInfoStackView.addArrangedSubview(secondWorkNameLabel)
        extraInfoStackView.addArrangedSubview(thirdWorkNameLabel)
        
        extraInfoStackView.axis = .vertical
        extraInfoStackView.spacing = 10.0
    }
    
    private func updateColors(color: UIColor) {
        view.backgroundColor = color
        extraContactLabel.backgroundColor = color
        firstWorkNameLabel.backgroundColor = color
        secondWorkNameLabel.backgroundColor = color
        thirdWorkNameLabel.backgroundColor = color
    }
    
    private func updateSwipe(acceptUser: Bool?) {
        if let userPersonalData = model.getCurrentUserInfo() {
            if let acceptUser = acceptUser {
                DispatchQueue.main.async {
                    self.model.updateCurrentUserInfoAfterSwipe(personalData: userPersonalData, id: self.model.lastID, status: acceptUser) { _ in}
                }
            }
            model.nextSwipe(currentUser: userPersonalData) { [self] result in
                switch result {
                case .success(let userToSwipe):
                    updateColors(color: .white)
                    profileImageView.image = UIImage(named: "defaultProfilePhoto_image")
                    
                    firstnameLabel.text = userToSwipe.firstName
                    lastnameLabel.text = userToSwipe.lastName
                    universityLabel.text = userToSwipe.university
                    statusLabel.text = userToSwipe.status
                    
                    if userToSwipe.works.count != 0{
                        extraContactLabel.text = userToSwipe.works[0]
                        firstWorkNameLabel.text = userToSwipe.works[1]
                        secondWorkNameLabel.text = userToSwipe.works[2]
                        thirdWorkNameLabel.text = userToSwipe.works[3]
                    }
                    
                    
                    model.getSwipeUserAvatar(user: userToSwipe) { result in
                        switch result {
                        case .success(let image):
                            self.profileImageView.image = image
                        case .failure(_):
                            print("Error download image")
                        }
                    }
                case .failure(_):
                    self.navigationController?.pushViewController(SwipeStateViewController(), animated: true)
                }
            }
        }
    }
    
    @objc private func leftSwiped(_ gesture: UISwipeGestureRecognizer) {
        updateColors(color: .red)
        updateSwipe(acceptUser: false)
    }
    
    @objc private func rightSwiped(_ gesture: UISwipeGestureRecognizer) {
        updateColors(color: .green)
        updateSwipe(acceptUser: true)
    }
}
