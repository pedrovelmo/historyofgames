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
    
    var highScores: [Int] = []
    
    var coinsTotal: Int = 0
}
