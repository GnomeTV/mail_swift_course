import Foundation
import UIKit

protocol IMatchViewModel {
    func getMatches()
    var matches: [(matchUser: PersonalData?, matchUserAvatar: UIImage?)] { get }
}

class MatchViewModel: IMatchViewModel {
    private let userManager: IUserManager
    private let userDefaultsManager: IUserDeafaultsManager
    var matches: [(matchUser: PersonalData?, matchUserAvatar: UIImage?)] = []
    
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
            for matchUserID in currentUser.matches {
                getUserInfoFromServer(id: matchUserID) { result in
                    switch result {
                    case .success(let matchUserData):
                        self.getUserAvatar(user: matchUserData) { result in
                            switch result {
                            case .success(let matchUserAvatar):
                                self.matches.append((matchUserData, matchUserAvatar))
                                print(self.matches)
                            case .failure(_):
                                self.matches.append((matchUserData, nil))
                            }
                        }
                    case .failure(_):
                        self.matches.append((nil, nil))
                    }
                }
            }
        }
    }
}
