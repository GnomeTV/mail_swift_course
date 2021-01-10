import UIKit

class ContactTableViewCell: UITableViewCell {
    
    var match: PersonalData? {
        didSet {
            guard let matchItem = match else {return}
            profileImageView.image = UIImage(named: "profile_icon")
            nameLabel.text = matchItem.firstName + " " + matchItem.lastName
            emailLabel.text = matchItem.email
            for job in matchItem.works {
                print(job)
                worksLabel.text? += job + "; "
            }
            worksLabel.text?.removeLast()
            worksLabel.text?.removeLast()
            

        }
    }
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let worksLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(profileImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(emailLabel)
        containerView.addSubview(worksLabel)
        self.contentView.addSubview(containerView)
        
        profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo:self.nameLabel.leadingAnchor).isActive = true

        worksLabel.topAnchor.constraint(equalTo:self.emailLabel.bottomAnchor).isActive = true
        worksLabel.leadingAnchor.constraint(equalTo:self.emailLabel.leadingAnchor).isActive = true

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

}
