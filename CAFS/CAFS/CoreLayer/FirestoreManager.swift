//
//  FirestoreManager.swift
//  CAFS
//
//  Created by Павел Травкин on 27.10.2020.
//
import UIKit
import Firebase

class FirestoreManager: NSObject {

    let db = Firestore.firestore()
    
    func addDocument(firstname : String,
                     lastname : String,
                     born : String,
                     university : String,
                     status : String){
        
        let newDocument = db.collection("users").document()
        
        newDocument.setData([
            "firstname" : firstname,
            "lastname" : lastname,
            "born" : born,
            "university" : university,
            "status" : status,
            "id" : newDocument.documentID
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(newDocument.documentID)")
            }
        }
        
    }
    
    func deleteDocument(id : String){
        
        db.collection("users").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func editDocument(id : String,
                      firstname : String = "",
                      lastname : String = "",
                      born : String = "",
                      university : String = "",
                      status : String = ""){
        
        var documentDataDictionary: [String: String] = [:]
        
        if (firstname != "") {
            documentDataDictionary["firstname"] = firstname
        }
        if (lastname != "") {
            documentDataDictionary["lastname"] = lastname
        }
        if (born != "") {
            documentDataDictionary["born"] = born
        }
        if (university != "") {
            documentDataDictionary["university"] = university
        }
        if (status != "") {
            documentDataDictionary["status"] = status
        }
        
        documentDataDictionary["id"] = id
        
        db.collection("users").document(id).setData(documentDataDictionary) { err in
            if let err = err {
                print("Error editing document: \(err)")
            } else {
                print("Document successfully edited!")
            }
        }
        
    }
}
