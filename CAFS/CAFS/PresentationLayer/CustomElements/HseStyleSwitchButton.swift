import UIKit

class HseStyleSwitchButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        initializeButton()
        checkSelection()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeButton()
    }
    
    private func checkSelection() {
        if self.isSelected {
            self.backgroundColor = UIColor.hseBlue
        }
        else if !self.isSelected {
            self.backgroundColor = UIColor.gray
        }
    }
    
    private func initializeButton() {
        self.layer.cornerRadius = 8.0
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        self.titleLabel?.textAlignment = .center
    }
}
