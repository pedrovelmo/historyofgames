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
    
    var highScores: [Int] = [0,0,0,0,0]
    
    var coinsTotal: Int = 0
    
    var userDefaults = UserDefaults.standard

    func updateUserData(coins: Int, highScore: Int){
        
        print("Pontuação enviada: \(highScore)")
        print("Moedas enviadas: \(coins)")
        
        var printIndex = -1
        
        self.coinsTotal += coins
        print("Moedas totais do jogador: \(self.coinsTotal)")
        
        userDefaults.set(self.coinsTotal, forKey: "coinsTotal")
        
        var index = -1
        
        for score in highScores{
            
            index += 1
            if(highScore >= score){
                
                if(highScores.count == 5){
                    
                    highScores[index] = highScore
                    break
                }
                else{
                    
                    highScores.append(highScore)
                    highScores = highScores.sorted(by: { $0 > $1 })
                    break
                }
            }
        }
        
        userDefaults.set(highScores[0], forKey: "highScore")
        
        for score in highScores{
            
            printIndex += 1
            
            print("Pontuação\(printIndex): \(score)")
        }
    }
}
