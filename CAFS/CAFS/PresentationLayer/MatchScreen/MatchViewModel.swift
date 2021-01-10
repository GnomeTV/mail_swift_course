import Foundation
import UIKit

protocol IMatchViewModel {
    func getMatches()
    func getUserInfoFromServer(id: String, _ completion: @escaping (Result<PersonalData, Error>) -> Void)
    func getUserAvatar(user: PersonalData, _ completion: @escaping (Result<UIImage, Error>) -> Void)
    var matchesIDs: [String] { get }
}

class MatchViewModel: IMatchViewModel {
    private let userManager: IUserManager
    private let userDefaultsManager: IUserDeafaultsManager
    var matchesIDs: [String] = []
    
    init(userManager: IUserManager, userDefaultsManager: IUserDeafaultsManager) {
        self.userManager = userManager
        self.userDefaultsManager = userDefaultsManager
        getMatches()
    }
    
    func getUserAvatar(user: PersonalData, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        userManager.getImage(user: user, completion)
    }
    
    func getUserInfoFromServer(id: String, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        userManager.getUserData(id: id, completion)
    }
    
    func getMatches() {
        if let currentUser = userDefaultsManager.getUserInfo() {
            matchesIDs = []
            for matchUserID in currentUser.matches {
                if !matchesIDs.contains(matchUserID) {
                    matchesIDs.append(matchUserID)
                }
            }
        }
    }
}
