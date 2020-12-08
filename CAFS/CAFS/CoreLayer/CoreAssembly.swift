import Foundation

protocol ICoreAssembly {
    var firestoreManager : IFirestoreManager { get }
    var userPersonalData: PersonalData { get set }
}

final class CoreAssembly: ICoreAssembly {
    
    let firestoreManager: IFirestoreManager = FirestoreManager()
    
    var userPersonalData: PersonalData = PersonalData(firstName: "", lastName: "", university: "", status: "", avatar: "", works: [""], matches: [""], email: "", password: "")
}
