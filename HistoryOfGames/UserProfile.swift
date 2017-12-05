//
//  UserProfile.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 13/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import Foundation

let userProfile = UserProfile()

class UserProfile{
    
    class var sharedInstance: UserProfile{
        
        return userProfile
    }
    
    var id: String = ""
    
    var firstLogin: Bool = false
    
    var highScore = 0
    
    var coinsTotal: Int = 0
    
    var userDefaults = UserDefaults.standard
    
    var gameModeStore: Bool = false
    
    var characterSelected: String = "didoStore"

    func updateUserData(coins: Int, score: Int){
        
        self.coinsTotal += coins
        
        userDefaults.set(self.coinsTotal, forKey: "coinsTotal")
        
        if(score >= highScore){
                    
            highScore = score
            userDefaults.set(highScore, forKey: "highScore")
        }
        // Atualizar o userDefault com um timestamp
    }
    
    func loadUserData(){
        
        if let highscore = UserProfile.sharedInstance.userDefaults.value(forKey: "coinsTotal") {
            
            self.highScore = UserProfile.sharedInstance.userDefaults.value(forKey: "highScore") as! Int
        }
        else {
            
            userDefaults.set(0, forKey: "highScore")
        }
        
        if let coinsTotal = UserProfile.sharedInstance.userDefaults.value(forKey: "coinsTotal") {
            
            self.coinsTotal = UserProfile.sharedInstance.userDefaults.value(forKey: "coinsTotal") as! Int
        }
        else {
            
            userDefaults.set(0, forKey: "coinsTotal")
        }
        
        if let firstLogin = UserProfile.sharedInstance.userDefaults.value(forKey: "firstLogin") {
            self.firstLogin = UserProfile.sharedInstance.userDefaults.value(forKey: "firstLogin") as! Bool
            print("First Login", self.firstLogin)
    }
        else {
            userDefaults.set(true, forKey: "firstLogin")
            self.firstLogin = true
            
        }
    }
}
