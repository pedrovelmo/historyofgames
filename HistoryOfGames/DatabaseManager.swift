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
    
//    var ref: DatabaseReference = Database.database().reference()
    
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
                    
                    UserProfile.sharedInstance.id = (user?.uid)!
                    UserProfile.sharedInstance.coinsTotal = 0
                    UserProfile.sharedInstance.highScores = []
                    self.setupNewUser()
                }
            }
        }
        
        else{
            
            print("Usuário já logado: " + (Auth.auth().currentUser?.uid)!)
            UserProfile.sharedInstance.id = (Auth.auth().currentUser?.uid)!
            getUserData()
        }
    }
    
    func setupNewUser(){
        
        
    }
    
    func getUserData(){
        
        
    }
    
    func addCoinsToDatabase(coins: Int){
        
        
    }
}
