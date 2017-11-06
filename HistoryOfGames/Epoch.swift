//
//  Epoch.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 31/08/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


class Epoch {
    
    var background : [Background]?
    var timeInEpoch: Timer?
    var floors: [Floor]?
    var whatEpochIsThis: Int?
    var obstacles: [String]?
    var numberOfCoins: Int?
    var scene: SKScene?
    
    //TO-DO: Set timer when call init
    init(whatEpochIsThis: Int, scene: SKScene, gameMode: String) {
        
        self.whatEpochIsThis = whatEpochIsThis
        self.scene = scene
        
        switch whatEpochIsThis {
            
        // Transition epoch
        case -1:
            
            background = [Background(epochId: whatEpochIsThis)]
            floors = [Floor(epochId: whatEpochIsThis, screenSize: scene.size)]
            obstacles = []
            
        case 0:
            
            background = [Background(epochId: whatEpochIsThis)]
            floors = [Floor(epochId: whatEpochIsThis, screenSize: scene.size)]
            obstacles = ["pongBall", "pongBar"]
            if (gameMode == "easy") {
            numberOfCoins = 1000
            }
            else if (gameMode == "medium") {
            numberOfCoins = 2000
                
            }
            
            else if (gameMode == "hard") {
                numberOfCoins = 3000
                
            }
            
        case 1:
            background = [Background(epochId: whatEpochIsThis)]
            floors = [Floor(epochId: whatEpochIsThis, screenSize: scene.size)]
            obstacles = ["pacmanBlock0"]
            if (gameMode == "easy") {
                numberOfCoins = 2000
            }
            else if (gameMode == "medium") {
                numberOfCoins = 4000
                
            }
                
            else if (gameMode == "hard") {
                numberOfCoins = 6000
                
            }
        case 2:
            background = [Background(epochId: whatEpochIsThis)]
            floors = [Floor(epochId: whatEpochIsThis, screenSize: scene.size)]
            obstacles = ["turtle0"]
            if (gameMode == "easy") {
                numberOfCoins = 4000
            }
            else if (gameMode == "medium") {
                numberOfCoins = 8000
                
            }
                
            else if (gameMode == "hard") {
                numberOfCoins = 12000
                
            }
            
        default: break
        }
    }
}
