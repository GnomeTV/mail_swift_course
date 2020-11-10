import Foundation
import CryptoKit

func genHash(string : String) -> String
{
    var result = SHA512.hash(data: [UInt8](string.utf8)).hashValue
    if result < 0 { result = -result }
    return String(result)
}
