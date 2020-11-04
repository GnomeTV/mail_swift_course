//
//  FirestoreManager.swift
//  CAFS
//
//  Created by Павел Травкин on 27.10.2020.
//
import UIKit
import Firebase

protocol IFirestoreManager{
    func addDocument(collection : String, params : [String : Any], _ completion: @escaping (_ error: Error?) -> ())
    
    func deleteDocument(collection : String, id : String, _ completion: @escaping (_ error: Error?) -> ())
    
    func editDocument(collection : String, id : String, params : [String : Any], _ completion: @escaping (_ error: Error?) -> ())
}

class FirestoreManager: IFirestoreManager {

    private let db = Firestore.firestore()
    
    func addDocument(collection : String, params : [String : Any], _ completion: @escaping (_ error: Error?) -> ()){
        
        let newDocument = db.collection(collection).document()
        
        newDocument.setData(params, completion: completion)
        
    }
    
    func deleteDocument(collection : String, id : String, _ completion: @escaping (_ error: Error?) -> ()){
        
    db.collection(collection).document(id).delete(completion: completion)
        
    }
    
    func editDocument(collection : String, id : String, params : [String : Any], _ completion: @escaping (_ error: Error?
    ) -> ()) {
        
        var newParams = params
        newParams["id"] = id
        
        db.collection(collection).document(id).setData(newParams, completion: completion)
        
    }
}
