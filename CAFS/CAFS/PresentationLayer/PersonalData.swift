import Foundation

struct PersonalData: Codable {
    var firstName: String
    var lastName: String
    var university: String
    var email: String
    private(set) var password: String
    
    init(firstName: String, lastName: String, university: String, email: String, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.university = university
        self.email = email
        self.password = Self.safePassword(password, email)
    }
    
    mutating func setPassword(_ password : String) {
        self.password = Self.safePassword(password, self.email)
    }
    
    private static func safePassword(_ password: String, _ email: String) -> String {
        let emailHash = String(format: "%02X", email.hash)
        let passwordHash = String(format: "%02X", password.hash)
        return (emailHash + passwordHash).genSecureHash()
    }
    
    func checkPassword( _ email: String, _ password: String) -> Bool {
        let checkingPassword = Self.safePassword(password, email)
        return self.password == checkingPassword
    }
}
