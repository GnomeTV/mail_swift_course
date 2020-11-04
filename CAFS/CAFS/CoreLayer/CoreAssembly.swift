import Foundation

protocol ICoreAssembly {
    var firestoreManager : FirestoreManager { get }
}

class CoreAssembly: ICoreAssembly {
    
    var firestoreManager = FirestoreManager()
    
}
