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
        obstacle.texture = SKTexture(imageNamed: "pacmanBlock" + String(randomImage))
        let width = Int(arc4random_uniform(30)) + 30
        let height = Int(arc4random_uniform(30)) + 30
        print("Width: ", width)
        print("Height: ", height)
        obstacle.size = CGSize(width: width, height: height)
        if (randomImage == 0) {

            obstacle.physicsBody = SKPhysicsBody(texture: obstacle.texture!,
                                                      size: CGSize(width: obstacle.size.width,
                                                                   height: obstacle.size.height))
            obstacle.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
            obstacle.physicsBody?.collisionBitMask = PhysicsCategory.Floor
            obstacle.physicsBody?.contactTestBitMask = PhysicsCategory.Player
            obstacle.physicsBody?.affectedByGravity = false
            obstacle.physicsBody?.friction = 0.0
            obstacle.physicsBody?.restitution = 1.0
            obstacle.physicsBody?.allowsRotation = false
            obstacle.physicsBody?.angularDamping = 0.0
            obstacle.physicsBody?.linearDamping = 0.0
        }
        else {
            obstacle.configPhysicsBody()
        }
        
        obstacle.position.y = CGFloat(arc4random_uniform(UInt32(((obstacle.getGameScene().size.height) * 0.6) - obstacle.size.height / 2))) + (obstacle.getGameScene().floorPosition)! + obstacle.size.height / 2
        
        obstacle.position.x = (obstacle.getGameScene().size.width) + 20
        print("Position x: ", obstacle.position.x)
        print("Position y: ", obstacle.position.y)
    }

    override func move() {
        obstacle.position.x -= (obstacle.getGameScene().movingSpeed)
    }
}





