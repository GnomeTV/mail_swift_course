import Foundation

final class PersonalData: Codable {
    var firstname = ""
    var lastname = ""
    var university = ""
    private var email = ""
    private var password = ""
    
    enum PersonalDataKeys: String, CodingKey { // declaring our keys
        case firstname
        case lastname
        case university
        case email
        case password
    }
    
    /*init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstname = try values.decode(String.self, forKey: .firstname)
        lastname = try values.decode(String.self, forKey: .lastname)
        university = try values.decode(String.self, forKey: .university)
        email = try values.decode(String.self, forKey: .email)
        password = try values.decode(String.self, forKey: .password)
    }*/
    
    private func generateHash() -> String {
        return (email+password).genHash()
    }
    
    static func getId(email : String) -> String {
        return email.genHash()
    }
    
    func getId() -> String {
        return email.genHash()
    }
    
    func setEmailAndPassword(email : String, password : String) {
        self.email = email
        self.password = (email+password).genHash()
    }
    
    func getEmail() -> String {
        return email
    }
}
