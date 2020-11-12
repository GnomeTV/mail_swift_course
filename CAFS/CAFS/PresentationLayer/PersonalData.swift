import Foundation

class PersonalData {
    private var firstname = ""
    private var lastname = ""
    private var university = ""
    private var email = ""
    private var password = ""
    
    private var isPasswordHashed = false
    
    private func generateHash() -> String {
        return genHash(string: email+password)
    }
    
    func setFirstname(firstname : String) {
        self.firstname = firstname
    }
    
    func setLastname(lastname : String) {
        self.lastname = lastname
    }
    
    func setUniversity(university : String) {
        self.university = university
    }
    
    func setEmail(email : String) {
        self.email = email
    }
    
    func setPassword(password : String) {
        isPasswordHashed = false
        self.password = password
    }
    
    func getFirstname() -> String {
        return firstname
    }
    
    func getLastname() -> String {
        return lastname
    }
    
    func getUniversity() -> String {
        return university
    }
    
    func getEmail() -> String {
        return email
    }
    
    func getPassword() -> String {
        if isPasswordHashed == true
        {
            return password
        } else {
            password = generateHash()
            isPasswordHashed = true
            return password
        }
    }
    
    func getDocForFirebase() -> PersonalDataDoc{
        
        let doc = PersonalDataDoc(firstname: firstname, lastname: lastname, university: university, email: email, password: getPassword())
        return doc
    }
}

struct PersonalDataDoc : Codable {
    let firstname : String
    let lastname : String
    let university : String
    let email : String
    let password : String
}
