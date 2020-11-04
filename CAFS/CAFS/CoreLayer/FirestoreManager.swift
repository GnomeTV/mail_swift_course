//
//  FirestoreManager.swift
//  CAFS
//
//  Created by Павел Травкин on 27.10.2020.
//
import UIKit
import Firebase
import FirebaseFirestoreSwift

protocol IFirestoreManager{
    func addDocument(collection : String, params : [String : Any], _ onErrorReceived: @escaping (_ error: Error) -> ())
    
    func deleteDocument(collection : String, id : String, _ onErrorReceived: @escaping (_ error: Error) -> ())
    
    func editDocument(collection : String, id : String, params : [String : Any], _ onErrorReceived: @escaping (_ error: Error) -> ())
    
}


class FirestoreManager: IFirestoreManager {

    private let db = Firestore.firestore()
    
    func addDocument(collection : String, params : [String : Any], _ onErrorReceived: @escaping (_ error: Error) -> ()){
        
        let newDocument = db.collection(collection).document()
        
        newDocument.setData(params) { error
            in
                guard let error = error
            else { return }
                onErrorReceived(error)
        }
        
    }
    
    func deleteDocument(collection : String, id : String, _ onErrorReceived: @escaping (_ error: Error) -> ()){
        
    db.collection(collection).document(id).delete() { error
        in
            guard let error = error
        else { return }
            onErrorReceived(error)
    }
    }
    
    func editDocument(collection : String, id : String, params : [String : Any], _ onErrorReceived: @escaping (_ error: Error) -> ()) {
        
        var newParams = params
        newParams["id"] = id
        
        db.collection(collection).document(id).setData(newParams) { error
            in
                guard let error = error
            else { return }
                onErrorReceived(error)
        }
        
        
    }
}
