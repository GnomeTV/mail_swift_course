import Foundation
import CryptoKit

extension String {
    func genHash() -> String
    {
        return String(format: "%02X", self.hash)
    }
}
