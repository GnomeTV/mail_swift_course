import UIKit

class HseStyleButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        initializeButton()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeButton()
    }
    
    private func initializeButton() {
        self.backgroundColor = UIColor.hseBlue
        self.layer.cornerRadius = 8.0
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        self.titleLabel?.textAlignment = .center
    }
}
