import Foundation

struct PersonalData: Codable {
    var firstName: String
    var lastName: String
    var university: String
    var status: String
    var avatar: String
    var works: [String]
    var matches: [String]
    var email: String
    private(set) var password: String
    
    init(firstName: String, lastName: String, university: String, status: String,
         avatar: String = "", works: [String] = [""], matches: [String] = [""], email: String, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.university = university
        self.status = status
        self.avatar = avatar
        self.works = works
        self.matches = matches
        self.email = email
        self.password = Self.safePassword(password, email)
    }
    
    init(personalData: PersonalData) {
        self.firstName = personalData.firstName
        self.lastName = personalData.lastName
        self.university = personalData.university
        self.status = personalData.status
        self.avatar = personalData.avatar
        self.works = personalData.works
        self.matches = personalData.matches
        self.email = personalData.email
        self.password = personalData.password
    }
    
    mutating func update(personalData: PersonalData) {
        self.firstName = personalData.firstName
        self.lastName = personalData.lastName
        self.university = personalData.university
        self.status = personalData.status
        self.avatar = personalData.avatar
        self.works = personalData.works
        self.matches = personalData.matches
        self.email = personalData.email
        self.password = personalData.password
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
    
    func isAnyBaseFieldsEmpty() -> Bool {
        return firstName.isEmpty || lastName.isEmpty || university.isEmpty || status.isEmpty
    }
}
