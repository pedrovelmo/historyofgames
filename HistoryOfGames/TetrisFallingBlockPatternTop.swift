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
        
        obstacle.position.y = (obstacle.gameScene?.size.height)! - obstacle.size.height / 2
    }
    
    override func move() {
        
        obstacle.position.x -= (obstacle.gameScene?.movingSpeed)!
    }
}
