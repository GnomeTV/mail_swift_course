import Foundation
import UIKit

protocol IMatchViewModel {
    func getMatches(_ completion: @escaping ([(matchUser: PersonalData?, matchUserAvatar: UIImage?)]) -> Void)
}

class MatchViewModel: IMatchViewModel {
    private let userManager: IUserManager
    private let userDefaultsManager: IUserDeafaultsManager
    
    init(userManager: IUserManager, userDefaultsManager: IUserDeafaultsManager) {
        self.userManager = userManager
        self.userDefaultsManager = userDefaultsManager
    }
    
    func getUserAvatar(user: PersonalData, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        userManager.getImage(user: user, completion)
    }
    
    func getUserInfoFromServer(id: String, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        userManager.getUserData(id: id, completion)
    }
    
    func getMatches(_ completion: @escaping ([(matchUser: PersonalData?, matchUserAvatar: UIImage?)]) -> Void) {
        var matches: [(PersonalData?, UIImage?)] = []
        if let currentUser = userDefaultsManager.getUserInfo() {
            for matchUserID in currentUser.matches {
                getUserInfoFromServer(id: matchUserID) { result in
                    switch result {
                    case .success(let matchUserData):
                        self.getUserAvatar(user: matchUserData) { result in
                            switch result {
                            case .success(let matchUserAvatar):
                                matches.append((matchUserData, matchUserAvatar))
                            case .failure(_):
                                matches.append((matchUserData, nil))
                            }
                        }
                    case .failure(_):
                        matches.append((nil, nil))
                    }
                }
            }
            completion(matches)
        }
    }
}
