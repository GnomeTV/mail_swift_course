
import UIKit

class UnderlineTextLabel: UILabel {
    
    private let bottomLine = UIView()
    private let indicatorHeight: CGFloat = 2.0
    private let topInsetTextFieldIndicator: CGFloat = 3.0
    private let fontSizeTextField: CGFloat = 20.0
    
    init() {
        super.init(frame: .zero)
        initializeTextField()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeTextField()
    }
    
    private func initializeTextField() {
        self.font = UIFont.systemFont(ofSize: fontSizeTextField, weight: .regular)
        self.textColor = .black
        self.addSubview(bottomLine)

        bottomLine.backgroundColor = UIColor.hseBlue
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.heightAnchor.constraint(equalToConstant: indicatorHeight).isActive = true
        bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomLine.topAnchor.constraint(equalTo: self.bottomAnchor, constant: topInsetTextFieldIndicator).isActive = true
    }
}
