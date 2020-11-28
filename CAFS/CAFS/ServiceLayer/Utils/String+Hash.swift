import Foundation

extension String {
    func genHash() -> String {
        String(format: "%02X", self.hash)
    }
    func genSecureHash() -> String {
        var result = ""
        for elem in self.utf8 {
            result += String(format: "%02X", elem.hashValue)
        }
        return result
    }
}
