//
//  ZeldaCrazyLinkSwordPattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 23/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class ZeldaCrazyLinkSwordPattern: EnemyPattern{
    
    let randomMovementPattern = arc4random_uniform(1)
    
    override init(obstacle: Obstacle) {
        super.init(obstacle: obstacle)
        
        obstacle.size = CGSize(width: 20, height: 20)
        
        self.obstacle.configPhysicsBody()
    }
    
    override func move() {
        
        switch randomMovementPattern {
            
        case 0:
            obstacle.position.x -= (obstacle.gameScene?.movingSpeed)! * 1.1
            
        case 1:
            break
            
        case 2:
            break
            
        default:
            break
        }
    }
}
