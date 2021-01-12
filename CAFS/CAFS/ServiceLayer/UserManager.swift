import Foundation
import FirebaseStorage

protocol IUserManager {
    /*func addNewUser(personalData : PersonalData, _ completion: @escaping (_ error: Error?) -> Void)
     
     func getUserData(id : String, _ completion: @escaping (Result<PersonalData, Error>) -> Void)
     
     func updateUserData(personalData : PersonalData, _ completion: @escaping (_ error: Error?) -> Void)
     
     func addImage(user: PersonalData, avatar: Data, _ completion: @escaping (Result< (StorageUploadTask, URL), Error>) -> Void)
     
     func getImage(user: PersonalData, _ completion: @escaping (Result<UIImage, Error>) -> Void)*/
    
    func initMainListener(email: String, _ completion: @escaping (Result<PersonalData, Error>) -> Void)
    
    func isUserExist(email: String, _ completion: @escaping (_ isUserExist: Bool) -> Void)
    
    func getUserData(id : String, _ completion: @escaping (Result<PersonalData, Error>) -> Void)
    
    func updateUserCache(userData: PersonalData)
    
    func updateAvatarFromServer(userData: PersonalData, _ completion: @escaping (_ isUserExist: UIImage?) -> Void)
    
    func addNewUserAvatarCache(userAvatar: UIImage?)
    
    func updateUserAvatarCache(userAvatar: UIImage?)
    
    func getUserInfoFromCache() -> PersonalData?
    
    func getUserAvatarFromCache() -> UIImage?
    
    func stopListen()
}

class UserManager : IUserManager {
    
    enum UserManagerError: Error {
        case documentDataIsMissing
        case localUpdate
    }
    
    private static let collection = "users"
    
    private let firestoreManager: IFirestoreManager
    private let userDefaultsManager: IUserDeafaultsManager
    
    //private var observingUserData: PersonalData? = nil
    
    init(firestoreManager: IFirestoreManager, userDefaultsManager: IUserDeafaultsManager) {
        self.firestoreManager = firestoreManager
        self.userDefaultsManager = userDefaultsManager
    }
    
    /*func addNewUser(personalData : PersonalData, _ completion: @escaping (_ error: Error?) -> Void) {
     let id = personalData.email.genHash()
     firestoreManager.addNewDocument(collection: Self.collection, id: id, data: personalData, completion)
     }
     
     func updateUserData(personalData : PersonalData, _ completion: @escaping (_ error: Error?) -> Void) {
     let id = personalData.email.genHash()
     firestoreManager.updateDocument(collection: Self.collection, id: id, data: personalData, completion)
     }
     
     func getUserData(id : String, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
     firestoreManager.getDocument(collection: Self.collection, id: id)  { result in
     switch result {
     case .success(let documentSnapshot):
     do {
     if let personalData = try documentSnapshot.data(as: PersonalData.self) {
     completion(.success(personalData))
     } else {
     completion(.failure(UserManagerError.documentDataIsMissing))
     }
     } catch {
     completion(.failure(error))
     }
     case .failure(let error):
     completion(.failure(error))
     }
     }
     }
     
     func userExist(email: String, _ completion: @escaping (_ userExists: Bool) -> Void) {
     do {
     let id = email.genHash()
     getUserData(id: id) { result in
     switch result {
     case .success(_):
     completion(true)
     case .failure(_):
     completion(false)
     }
     }
     }
     }
     }*/
    
    func initMainListener(email: String, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        let id = email.genHash()
        addUserDataListener(id: id) { result in
            switch result {
            case .success((let personalData, let source)):
                //self.observingUserData = personalData
                if !self.userDefaultsManager.isLogged() {
                    self.userDefaultsManager.initUser(userData: personalData)
                    return
                }
                self.userDefaultsManager.updateUserInfo(userData: personalData)
                print("Main Listener: from \(source) update")
                completion(.success(personalData))
                /*if source != "server" {
                    print("Main Listener: from server:\(source) update")
                    self.userDefaultsManager.updateUserInfo(userData: personalData)
                    completion(.success(personalData))
                    return
                } else {
                    print("Main Listener: from \(source) update")
                    completion(.failure(UserManagerError.localUpdate))
                    return
                }*/
            case .failure(let error):
                print(error)
                completion(.failure(error))
                return
            }
        }
    }
    
    func addUserDataListener(id: String, _ completion: @escaping (Result<(PersonalData, String), Error>) -> Void) {
        firestoreManager.addSnapshotListener(collection: Self.collection, id: id)  { result in
            switch result {
            case .success((let documentSnapshot, let source)):
                do {
                    if let personalData = try documentSnapshot.data(as: PersonalData.self) {
                        completion(.success((personalData, source)))
                    } else {
                        completion(.failure(UserManagerError.documentDataIsMissing))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func isUserExist(email: String, _ completion: @escaping (_ isUserExists: Bool) -> Void) {
        let id = email.genHash()
        getUserData(id: id) { result in
            switch result {
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
    
    func getUserData(id : String, _ completion: @escaping (Result<PersonalData, Error>) -> Void) {
        firestoreManager.getDocument(collection: Self.collection, id: id)  { result in
            switch result {
            case .success(let documentSnapshot):
                do {
                    if let personalData = try documentSnapshot.data(as: PersonalData.self) {
                        completion(.success(personalData))
                    } else {
                        completion(.failure(UserManagerError.documentDataIsMissing))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateUserCache(userData: PersonalData) {
        let id = userData.email.genHash()
        firestoreManager.updateDocument(collection: Self.collection, id: id, data: userData) { isSucceed in
            self.userDefaultsManager.updateUserInfo(userData: userData)
        }
    }
    
    func updateAvatarFromServer(userData: PersonalData, _ completion: @escaping (_ isUserExist: UIImage?) -> Void) {
        getImage(user: userData) { result in
            switch result {
            case .success(let avatar):
                self.updateUserAvatarCache(userAvatar: avatar)
                completion(avatar)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func updateUserAvatarCache(userAvatar: UIImage?) {
        userDefaultsManager.updateUserAvatar(avatar: userAvatar?.pngData())
    }
    
    func addNewUserAvatarCache(userAvatar: UIImage?) {
        let avatarPreHash = userAvatar ?? UIImage()
        let avatarHash = String(avatarPreHash.hash)
        if var userData = getUserInfoFromCache() {
            userData.avatar = avatarHash
            if let avatar = userAvatar?.pngData() {
                addImage(user: userData, avatar: avatar) { result in
                    switch result {
                    case .success((let uploadTask, _)):
                        uploadTask.observe(.success) { snapshot in
                            print("Image add to Server")
                            self.userDefaultsManager.updateUserAvatar(avatar: userAvatar?.pngData())
                            self.updateUserCache(userData: userData)
                            uploadTask.removeAllObservers()
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
        print("Success updateUserAvatarCache: \(avatarHash)")
    }
    
    func getUserInfoFromCache() -> PersonalData? {
        return userDefaultsManager.getUserInfo()
    }
    
    func getUserAvatarFromCache() -> UIImage? {
        if let userAvatar = userDefaultsManager.getUserAvatar() {
            if !userAvatar.isEmpty {
                return UIImage(data: userAvatar)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func addImage(user: PersonalData, avatar: Data, _ completion: @escaping (Result< (StorageUploadTask, URL), Error>) -> Void) {
        let path = "users/"+user.email.genHash()+"/"
        let imageName = "avatar.png"
        firestoreManager.addStorageObject(path: path, name: imageName, data: avatar, completion)
    }
    
    func getImage(user: PersonalData, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        let path = "users/"+user.email.genHash()+"/"
        let imageName = "avatar.png"
        //completion(.failure(UserManagerError.documentDataIsMissing))
        firestoreManager.getStorageObject(path: path, name: imageName) { result in
            switch result {
            case .success(let data):
                completion(.success(UIImage(data: data)!))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func stopListen() {
        firestoreManager.stopListen()
    }
}
