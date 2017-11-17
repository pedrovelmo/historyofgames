//
//  TetrisFallingBlockPatternA.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 17/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class TetrisFallingBlockPatternTop: EnemyPattern{
    
    override init(obstacle: Obstacle) {
        
        super.init(obstacle: obstacle)
        
        let height = (obstacle.gameScene?.size.height)! / 8
        let width = (obstacle.gameScene?.size.width)! / 10
        
        obstacle.size = CGSize(width: width, height: height)
        
        obstacle.position.x = (obstacle.gameScene?.size.width)! + 20
        obstacle.position.y = (obstacle.gameScene?.size.height)! - obstacle.size.height / 2
        obstacle.configPhysicsBody()
    }
    
    override func move() {
        
        obstacle.position.x -= (obstacle.gameScene?.movingSpeed)!
    }
}
