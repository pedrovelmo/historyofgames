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
            obstacles = ["pongBall", "pongBar"]
            numberOfCoins = 1000
            
        case 1:
            background = [Background(epochId: whatEpochIsThis)]
            floors = [Floor(epochId: whatEpochIsThis, screenSize: scene.size)]
            obstacles = ["pacmanBlock", "pacmanBlock1","blueGhost", "redGhost", "greenGhost", "greenishGhost", "yellowGhost"]
            numberOfCoins = 4000
        case 2:
            background = [Background(epochId: whatEpochIsThis)]
            floors = [Floor(epochId: whatEpochIsThis, screenSize: scene.size)]
            obstacles = ["block1", "block2", "block3", "block4", "turtle"]
            numberOfCoins = 1000000
            
        default: break
        }
    }
}
