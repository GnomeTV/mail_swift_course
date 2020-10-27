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
    
    func addDocunent(){
        
        var ref = db.collection("users").addDocument(data: [
            "name": "Tokyo",
            "country": "Japan"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
    }
}
