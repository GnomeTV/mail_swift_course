import Foundation

final class PersonalData: Codable {
    var firstname = ""
    var lastname = ""
    var university = ""
    private(set) var email = ""
    private var password = ""
    
    enum PersonalDataKeys: String, CodingKey {
        case firstname
        case lastname
        case university
        case email
        case password
    }
    
    func checkPassword(email : String, password : String) -> Bool {
        (String(format: "%02X", self.email.hash)+String(format: "%02X", self.password.hash)).genSecureHash() == (String(format: "%02X", email.hash)+String(format: "%02X", password.hash)).genSecureHash()
    }
    
    static func getId(email : String) -> String {
        return email.genHash()
    }
    
    func getId() -> String {
        return email.genHash()
    }
    
    func setEmailAndPassword(email : String, password : String) {
        self.email = email
        self.password = (String(format: "%02X", email.hash)+String(format: "%02X", password.hash)).genSecureHash()
    }
}
