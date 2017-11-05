//
//  PacmanBlockPattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class PacmanBlockPattern: EnemyPattern{
    
    override func startMoving(floorPosition: CGFloat, scene: SKScene) {
        
        let width = Int(arc4random_uniform(30)) + 40
        let height = Int(arc4random_uniform(30)) + 40
        obstacle.size = CGSize(width: width, height: height)
        
        obstacle.position.y = CGFloat(arc4random_uniform(UInt32(scene.size.height - obstacle.size.height / 2))) + floorPosition + obstacle.size.height / 2
        
        obstacle.position.x = scene.size.width + 20
        
        setObstaclePhysicsBody(obstacle: obstacle)
    }
}
