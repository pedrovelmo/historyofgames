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

    private var whatEpochIsThis: Int?
    private var obstacles: [String]?
    private var numberOfCoins: Int?
    private var scene: GameScene?
    
    
    init(whatEpochIsThis: Int, scene: GameScene) {
        
        self.whatEpochIsThis = whatEpochIsThis
        self.scene = scene
        
        switch whatEpochIsThis {
            
        // Transition epoch
        case -1:
            
            obstacles = []
            //numberOfCoins = (scene.lastEpoch?.whatEpochIsThis)! + 1
            
        case 0:

            obstacles = ["pongBall", "pongBar", "alien1-0"]
            numberOfCoins = 1000
            
        case 1:

            obstacles = ["ghost0", "pacmanBlock0", "tetrisTopBlockA"]
            numberOfCoins = 6000
            
        case 2:

//            obstacles = ["turtle0","block1","crazyAssLink"]
            obstacles = ["turtle0", "block1"]
            numberOfCoins = 600
            
        case 3:

            obstacles = ["pongBall", "pongBar", "alien1-0", "ghost0", "pacmanBlock0", "tetrisTopBlockA","block1", "turtle0"]
            numberOfCoins = 0
            
        default: break
        }
    }
    
    
    func getWhatEpochIsThis() -> Int {
        return self.whatEpochIsThis!
    }
    
    func getObstacles() -> [String] {
        return self.obstacles!
    }
    
    func getNumberOfCoins() -> Int {
        return self.numberOfCoins!
    }
    
}
