import UIKit

extension NSAttributedString {
    static func getAttributedErrorPlaceholder(for string: String) -> NSAttributedString {
        NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
    }
}
