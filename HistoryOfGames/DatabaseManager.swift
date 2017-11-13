//
//  DatabaseManager.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 12/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import Firebase

let instance = DatabaseManager()

class DatabaseManager{
    
    class var sharedInstance: DatabaseManager{
        return instance
    }
    
    func firebaseInit(){
        
        FirebaseApp.configure()
    }
}
