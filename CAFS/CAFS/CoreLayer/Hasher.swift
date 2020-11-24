import Foundation
import CryptoKit

extension String {
    func genHash() -> String
    {
        return String(format: "%02X", SHA512.hash(data: [UInt8](self.utf8)).hashValue)
    }
}
