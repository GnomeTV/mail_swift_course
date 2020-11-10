import Foundation
import CryptoKit

func genHash(string : String) -> String
{
    return String(format: "%02X", SHA512.hash(data: [UInt8](string.utf8)).hashValue)
}
