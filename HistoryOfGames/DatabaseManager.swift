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
    
    var ref: DatabaseReference?
    
    func firebaseInit(){
        
        FirebaseApp.configure()
        ref = Database.database().reference()
        
//        do{
//            try Auth.auth().signOut()
//        }
//
//        catch {}
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
        
        self.ref?.child("users").child(UserProfile.sharedInstance.id).setValue(["highScore": 0, "coinsTotal": 0])
    }
    
    func getUserData(){
        
        ref?.child("users").child(UserProfile.sharedInstance.id).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            UserProfile.sharedInstance.coinsTotal = value?.value(forKey: "coinsTotal") as! Int
            UserProfile.sharedInstance.highScores[0] = value?.value(forKey: "highScore") as! Int
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func updateUserData(){
        
        self.ref?.child("users").child(UserProfile.sharedInstance.id)
            .updateChildValues(["coinsTotal": UserProfile.sharedInstance.coinsTotal,
                                "highScore": UserProfile.sharedInstance.highScores[0]])
    }
}
