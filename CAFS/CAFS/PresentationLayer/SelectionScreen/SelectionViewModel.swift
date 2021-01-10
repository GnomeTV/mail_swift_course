import Foundation
import FirebaseStorage

protocol ISelectionViewModel {
    var lastID: String { get }
    func getCurrentUserInfo() -> PersonalData?
    func updateCurrentUserInfoAfterSwipe(personalData: PersonalData, id: String, status: Bool, _ completion: @escaping (_ success: Bool) -> Void)
    func getSwipeUserAvatar(user: PersonalData, _ completion: @escaping (Result<UIImage, Error>) -> Void)
    func nextSwipe(currentUser: PersonalData, _ completion: @escaping (Result<PersonalData, Error>) -> Void)
}

class SelectionViewModel: ISelectionViewModel {
    private let userManager: IUserManager
    private let userDefaultsManager: IUserDeafaultsManager
    private let swipeSelectionManager: ISwipeSelectionManager
    
    var lastID: String = ""
    
    init(userManager: IUserManager, userDefaultsManager: IUserDeafaultsManager, swipeSelectionManager: ISwipeSelectionManager) {
        self.userManager = userManager
        self.userDefaultsManager = userDefaultsManager
        self.swipeSelectionManager = swipeSelectionManager
    }
    
    func getCurrentUserInfo() -> PersonalData? {
        return userDefaultsManager.getUserInfo()
    }
    
    func updateCurrentUserInfo(personalData: PersonalData, _ completion: @escaping (_ success: Bool) -> Void) {
        userDefaultsManager.updateUserInfo(userData: personalData)
        userManager.updateUserData(personalData: personalData) { error in
            DispatchQueue.main.async {
                completion(error == nil)
            }
        }
    }
    
    func updateUserInfo(personalData: PersonalData, _ completion: @escaping (_ success: Bool) -> Void) {
        userManager.updateUserData(personalData: personalData) { error in
            DispatchQueue.main.async {
                completion(error == nil)
            }
        }
    }
    
    func getSwipeUserAvatar(user: PersonalData, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        userManager.getImage(user: user, completion)
    }
    
    func nextSwipe(currentUser: PersonalData, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        swipeSelectionManager.nextSwipe(currentUser: currentUser, checkQueue: false) { result in
            switch result {
            case .success(let pData):
                self.lastID = pData.email.genHash()
                completion(.success(pData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUserData(id: String, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        userManager.getUserData(id: id, completion)
    }
    
    func updateCurrentUserInfoAfterSwipe(personalData: PersonalData, id: String, status: Bool, _ completion: @escaping (_ success: Bool) -> Void) {
        var pData = personalData
        getUserData(id: id) { result in
            switch result {
            case .success(var swipedUserPersonalData):
                if status && !pData.swiped.contains(id) {
                    pData.swiped.append(id)
                    let currentUserID = pData.email.genHash()
                    if swipedUserPersonalData.swiped.contains(currentUserID) && !swipedUserPersonalData.matches.contains(currentUserID) {
                        swipedUserPersonalData.matches.append(currentUserID)
                        DispatchQueue.main.async {
                            self.updateUserInfo(personalData: swipedUserPersonalData) { _ in }
                        }
                        DispatchQueue.main.async {
                            pData.matches.append(id)
                            self.updateCurrentUserInfo(personalData: pData, completion)
                        }
                    } else {
                        self.updateCurrentUserInfo(personalData: pData, completion)
                    }
                }
            case .failure(_):
                completion(false)
            }
        }
    }
}
