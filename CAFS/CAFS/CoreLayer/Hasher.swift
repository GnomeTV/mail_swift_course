import Foundation
import CryptoKit

extension String {
    func genHash() -> String
    {
        String(format: "%02X", self.hash)
    }
}
