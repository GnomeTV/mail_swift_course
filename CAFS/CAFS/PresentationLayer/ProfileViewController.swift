import UIKit

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerControllerActionSheet() {
        let photoLibraryAction = UIAlertAction(title: "Открыть", style: .default) {
            (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Создать", style: .default) {
            (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        AlertService.showAlert(style: .actionSheet, title: "Выберете фото", message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
        
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImageView.image = editedImage
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.image = originalImage
        }
            
        
        dismiss(animated: true, completion: nil)
    }
    
}


class ProfileViewController: UIViewController {
    
    private let profileStackView = UIStackView()
    private let titleLabel = UILabel()
    private let profileImageView = UIImageView()
    private let profileImageButton = UIButton(type: .system)
    
    
    // MARK: - Insets
    
    private let leftInset: CGFloat = 24.0
    private let rightInset: CGFloat = 24.0
    private let buttonHeight: CGFloat = 48.0
    private let topInsetTextFieldIndicator: CGFloat = 3.0
    private let profileImageViewWidth: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    // MARK: - Private methods
    private func setupViews() {
        setupProfileLabel()
        setupStackView()
    }
    
    private func setupStackView() {
        view.addSubview(profileStackView)
        profileStackView.translatesAutoresizingMaskIntoConstraints = false
        profileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset + 100).isActive = true
        profileStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset - 100).isActive = true
        profileStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 114.0).isActive = true
        profileStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -600).isActive = true
        
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.masksToBounds = true
        profileImageView.backgroundColor = .clear
        
        
        profileImageButton.translatesAutoresizingMaskIntoConstraints = false
        profileImageButton.setImage(UIImage(named: "addimage_icon"), for: .normal)
        profileImageButton.layer.masksToBounds = true
        profileImageButton.addTarget(self, action: #selector(profileImageButtonTapped), for: .touchUpInside)
        
        profileStackView.addArrangedSubview(profileImageView)
        profileStackView.addArrangedSubview(profileImageButton)
        profileStackView.axis = .vertical
        profileStackView.spacing = 10.0
        
    }
    
    
    private func setupProfileLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = "Профиль"
        titleLabel.textColor = UIColor.hseBlue
        titleLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)

        titleLabel.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0).isActive = true
    }
    
    @objc private func profileImageButtonTapped() {
        
        print("Add profile photo")
        showImagePickerControllerActionSheet()

    }
}
