//
//  ZeldaCrazyLinkSwordPattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 23/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class ZeldaCrazyLinkSwordPattern: EnemyPattern{
    
    let randomMovementPattern = arc4random_uniform(3)
    
    override init(obstacle: Obstacle) {
        super.init(obstacle: obstacle)
        
        obstacle.size = CGSize(width: 20, height: 20)
        
        self.obstacle.configPhysicsBody()
    }
    
    override func move() {
        
        switch randomMovementPattern {
            
        case 0:
            // Straight Throw
            obstacle.position.x -= (obstacle.getGameScene().movingSpeed) * 1.7
            break
            
        case 1:
            // High Angled Throw
            obstacle.position.x -= (obstacle.getGameScene().movingSpeed) * 1.7
            obstacle.position.y += (obstacle.getGameScene().movingSpeed) * 0.5
            break
            
        case 2:
            // Low Angled Throw
            obstacle.position.x -= (obstacle.getGameScene().movingSpeed) * 1.7
            obstacle.position.y += (obstacle.getGameScene().movingSpeed) * 0.3
            break
            
        default:
            break
        }
    }
}
