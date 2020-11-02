//
//  FirestoreManager.swift
//  CAFS
//
//  Created by Павел Травкин on 27.10.2020.
//
import UIKit
import Firebase

protocol IFirestoreManager{
    func addDocument(collection : String,
                     firstname : String,
                     lastname : String,
                     password : String,
                     born : String,
                     university : String,
                     status : String) -> String
    
    func deleteDocument(collection : String, id : String) -> String
    
    func editDocument(collection : String,
                      id : String,
                      firstname : String,
                      lastname : String,
                      password : String,
                      born : String,
                      university : String,
                      status : String) -> String
}


class FirestoreManager: NSObject, IFirestoreManager, ICoreAssembly {

    private let db = Firestore.firestore()
    
    func addDocument(collection : String,
                     firstname : String,
                     lastname : String,
                     password : String,
                     born : String,
                     university : String,
                     status : String) -> String {
        
        let newDocument = db.collection(collection).document()
        
        newDocument.setData([
            "firstname" : firstname,
            "lastname" : lastname,
            "password" : password,
            "born" : born,
            "university" : university,
            "status" : status,
            "id" : newDocument.documentID
        ]) { err in
            if let err = err {
                return "Error adding document: \(err)"
            } else {
                return "Document added with ID: \(newDocument.documentID)"
            }
        }
        
    }
    
    func deleteDocument(collection : String, id : String) -> String{
        
        db.collection(collection).document(id).delete() { err in
            if let err = err {
                return "Error removing document: \(err)"
            } else {
                return "Document successfully removed!"
            }
        }
    }
    
    func editDocument(collection : String,
                      id : String,
                      firstname : String = "",
                      lastname : String = "",
                      password : String = "",
                      born : String = "",
                      university : String = "",
                      status : String = "") -> String {
        
        var documentDataDictionary: [String: String] = [:]
        
        if (firstname.isEmpty) {
            documentDataDictionary["firstname"] = firstname
        }
        if (lastname.isEmpty) {
            documentDataDictionary["lastname"] = lastname
        }
        if (password.isEmpty) {
            documentDataDictionary["password"] = password
        }
        if (born.isEmpty) {
            documentDataDictionary["born"] = born
        }
        if (university.isEmpty) {
            documentDataDictionary["university"] = university
        }
        if (status.isEmpty) {
            documentDataDictionary["status"] = status
        }
        
        documentDataDictionary["id"] = id
        
        db.collection(collection).document(id).setData(documentDataDictionary) { err in
            if let err = err {
                return "Error editing document: \(err)"
            } else {
                return "Document successfully edited!"
            }
        }
        
    }
}
