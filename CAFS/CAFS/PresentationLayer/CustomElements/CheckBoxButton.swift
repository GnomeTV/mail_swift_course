import UIKit

protocol checkBoxDelegate {
    func didTapCheckbox(isChecked: Bool, type: String)
}

class CheckBoxButton: UIButton {
    let checkedImage = UIImage(named: "checked")! as UIImage
    let uncheckedImage = UIImage(named: "unchecked")! as UIImage
    public var delegate: checkBoxDelegate?
    public var type: String?
    
    init() {
        super.init(frame: .zero)
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public var isChecked: Bool = false {
            didSet{
                if isChecked == true {
                    self.setImage(checkedImage, for: .normal)
                } else {
                    self.setImage(uncheckedImage, for: .normal)
                }
            }
        }


    @objc private func buttonClicked(sender: UIButton) {
      
        if sender == self {
            isChecked = !isChecked
            delegate?.didTapCheckbox(isChecked: isChecked, type: type!)
        }
        else {
            print("else")
        }
    }
}
