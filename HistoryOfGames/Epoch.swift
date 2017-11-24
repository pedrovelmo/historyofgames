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
    init(whatEpochIsThis: Int, scene: SKScene) {
        
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
            obstacles = ["pongBall", "pongBar", "alien1-0"]
            numberOfCoins = 3000
            
        case 1:
            background = [Background(epochId: whatEpochIsThis)]
            floors = [Floor(epochId: whatEpochIsThis, screenSize: scene.size)]
            obstacles = ["ghost0", "pacmanBlock0", "tetrisTopBlockA"]
            numberOfCoins = 6000
            
        case 2:
            background = [Background(epochId: whatEpochIsThis)]
            floors = [Floor(epochId: whatEpochIsThis, screenSize: scene.size)]
            obstacles = ["turtle0","block1","crazyAssLink"]
//            obstacles = ["turtle0"]
            numberOfCoins = 12000
            
        case 3:
            background = [Background(epochId: whatEpochIsThis)]
            floors = [Floor(epochId: whatEpochIsThis, screenSize: scene.size)]
            obstacles = ["pongBall", "pongBar", "alien1-0", "ghost0", "pacmanBlock0", "tetrisTopBlockA","block1", "turtle0"]
            numberOfCoins = 99999999999999
            
        default: break
        }
    }
}
