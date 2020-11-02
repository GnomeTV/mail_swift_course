//
//  FirestoreManager.swift
//  CAFS
//
//  Created by Павел Травкин on 27.10.2020.
//
import UIKit
import Firebase

protocol IFirestoreManager{
    func addDocument(collection : String, params : [String : Any], _ onErrorReceived: @escaping (_ error: Error) -> ())
    
    func deleteDocument(collection : String, id : String)
    
    func editDocument(collection : String, id : String, params : [String : Any])
    
}


class FirestoreManager: IFirestoreManager {

    private let db = Firestore.firestore()
    
    func addDocument(collection : String, params : [String : Any], _ onErrorReceived: @escaping (_ error: Error) -> ()){
        
        let newDocument = db.collection(collection).document()
        
        newDocument.setData(params) { err in onErrorReceived(err) }
        
    }
    
    func deleteDocument(collection : String, id : String){
        
        db.collection(collection).document(id).delete()
    }
    
    func editDocument(collection : String, id : String, params : [String : Any]) {
        
        var newParams = params
        newParams["id"] = id
        
        db.collection(collection).document(id).setData(newParams)
        
        
    }
}
