import Foundation

protocol ISwipeStateViewModel {
    func checkQueueSwipeState(currentUser: PersonalData, _ completion: @escaping (Error?) -> Void)
    func getUserInfo() -> PersonalData?
}

class SwipeStateViewModel: ISwipeStateViewModel {
    private let userDefaultsManager: IUserDeafaultsManager
    private let swipeSelectionManager: ISwipeSelectionManager
    
    var lastID: String = ""
    
    init(swipeSelectionManager: ISwipeSelectionManager, userDefaultsManager: IUserDeafaultsManager) {
        self.swipeSelectionManager = swipeSelectionManager
        self.userDefaultsManager = userDefaultsManager
    }
    
    func checkQueueSwipeState(currentUser: PersonalData, _ completion: @escaping (Error?) -> Void) {
        swipeSelectionManager.nextSwipe(currentUser: currentUser, checkQueue: true) { result in
            switch result {
            case .success(_):
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func getUserInfo() -> PersonalData? {
        return userDefaultsManager.getUserInfo()
    }
}
