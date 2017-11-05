//
//  PongBallPattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class PongBallPattern: EnemyPattern{
    
    override func startMoving(floorPosition: CGFloat, scene: SKScene) {
        
        obstacle.size = CGSize(width: 10, height: 10)
        
        let randomPosition = arc4random_uniform(UInt32(scene.size.height))
        
        obstacle.position = CGPoint(x: scene.size.width + 20, y: CGFloat(CGFloat(randomPosition) + floorPosition))
        
        setObstaclePhysicsBody(obstacle: obstacle)
        
        obstacle.physicsBody?.mass = (obstacle.physicsBody?.mass)! * 8
        let randomX = -Double(arc4random_uniform(UInt32(obstacle.movementSpeed * 1.7))) - 6.0
        var randomY: Double!
        let yType = arc4random_uniform(2)
        if (yType == 0) {
            randomY = -randomX
        }
            
        else {
            
            randomY = randomX
        }
        
        obstacle.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
    }
}
