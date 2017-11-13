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
    
    func anonymousLogin(){
        
        if(Auth.auth().currentUser == nil){
            
            Auth.auth().signInAnonymously() { (user, error) in
                
                if let error = error {
                    
                    print("Sign in failed:", error.localizedDescription)
                }
                
                else{
                    
                    let uid = user!.uid
                    print("ID gerado para o usuário: " + user!.uid)
                }
            }
        }
        
        else{
            
            print("Usuário já logado: " + (Auth.auth().currentUser?.uid)!)
        }
    }
}
