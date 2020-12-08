import Foundation

protocol ICoreAssembly {
    var firestoreManager : IFirestoreManager { get }
}

final class CoreAssembly: ICoreAssembly {
    
    let firestoreManager: IFirestoreManager = FirestoreManager()
    
}
