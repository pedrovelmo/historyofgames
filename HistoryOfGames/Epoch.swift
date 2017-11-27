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
    var scene: GameScene?
    
    //TO-DO: Set timer when call init
    init(whatEpochIsThis: Int, scene: GameScene) {
        
        self.whatEpochIsThis = whatEpochIsThis
        self.scene = scene
        
        switch whatEpochIsThis {
            
        // Transition epoch
        case -1:
            background = [Background(epochId: whatEpochIsThis)]
            floors = [Floor(epochId: whatEpochIsThis, screenSize: scene.size)]
            obstacles = []
            //numberOfCoins = (scene.lastEpoch?.whatEpochIsThis)! + 1
            
        case 0:
            background = [Background(epochId: whatEpochIsThis)]
            floors = [Floor(epochId: whatEpochIsThis, screenSize: scene.size)]
            obstacles = ["pongBall", "pongBar", "alien1-0"]
            numberOfCoins = 400
            
        case 1:
            background = [Background(epochId: whatEpochIsThis)]
            floors = [Floor(epochId: whatEpochIsThis, screenSize: scene.size)]
            obstacles = ["ghost0", "pacmanBlock0", "tetrisTopBlockA"]
            numberOfCoins = 600
            
        case 2:
            background = [Background(epochId: whatEpochIsThis)]
            floors = [Floor(epochId: whatEpochIsThis, screenSize: scene.size)]
//            obstacles = ["turtle0","block1","crazyAssLink"]
            obstacles = ["turtle0", "block1"]
            numberOfCoins = 800
            
        case 3:
            background = [Background(epochId: whatEpochIsThis)]
            floors = [Floor(epochId: whatEpochIsThis, screenSize: scene.size)]
            obstacles = ["pongBall", "pongBar", "alien1-0", "ghost0", "pacmanBlock0", "tetrisTopBlockA","block1", "turtle0"]
            numberOfCoins = 99999999999999
            
        default: break
        }
    }
}
