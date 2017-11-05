//
//  MarioSuperBlockPattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class MarioSuperBlockPattern: EnemyPattern{
    
    override func startMoving(floorPosition: CGFloat, scene: SKScene) {
        
        obstacle.size = CGSize(width: 120, height: 50)
        
        obstacle.position.y = CGFloat(arc4random_uniform(UInt32(scene.size.height - obstacle.size.height / 2))) + floorPosition + obstacle.size.height / 2
        
        obstacle.position.x = scene.size.width + 70
        
        setObstaclePhysicsBody(obstacle: obstacle)
    }
}
