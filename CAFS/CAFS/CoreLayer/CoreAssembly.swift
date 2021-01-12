import Foundation

protocol ICoreAssembly {
    var firestoreManager : IFirestoreManager { get }
    var userDefaultsManager: IUserDeafaultsManager { get }
}

final class CoreAssembly: ICoreAssembly {
    let firestoreManager: IFirestoreManager = FirestoreManager()
    let userDefaultsManager: IUserDeafaultsManager = UserDefaultsManager()
}
