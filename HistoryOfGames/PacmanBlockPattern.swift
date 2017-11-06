//
//  PacmanBlockPattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class PacmanBlockPattern: EnemyPattern{
    
    override init(obstacle: Obstacle) {
        
        super.init(obstacle: obstacle)
        
        let randomImage = arc4random_uniform(2)
        
        self.obstacle.texture = SKTexture(imageNamed: "pacmanBlock" + String(randomImage))
        
        let width = Int(arc4random_uniform(30)) + 40
        let height = Int(arc4random_uniform(30)) + 40
        obstacle.size = CGSize(width: width, height: height)
        
        obstacle.position.y = CGFloat(arc4random_uniform(UInt32((obstacle.gameScene?.size.height)! - obstacle.size.height / 2))) + (obstacle.gameScene?.floorPosition)! + obstacle.size.height / 2
        
        obstacle.position.x = (obstacle.gameScene?.size.width)! + 20
        
        setObstaclePhysicsBody(obstacle: obstacle)
    }

    override func move() {
        
        obstacle.position.x -= (obstacle.gameScene?.movingSpeed)!
    }
}





