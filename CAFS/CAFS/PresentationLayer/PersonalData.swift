import Foundation

class PersonalData: Codable {
    var firstname = ""
    var lastname = ""
    var university = ""
    private var email = ""
    private var password = ""
    
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
