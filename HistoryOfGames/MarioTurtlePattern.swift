//
//  TurtlePattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class MarioTurtlePattern: EnemyPattern{
    
    override init(obstacle: Obstacle) {
        
        super.init(obstacle: obstacle)
        
        let randomPositionY = CGFloat(arc4random_uniform(UInt32((obstacle.gameScene?.size.height)!)))
        
        obstacle.position = CGPoint(x: (obstacle.gameScene?.size.width)! + 20,
                                    y: randomPositionY + (obstacle.gameScene?.floorPosition)!)
        
        print("Position turtle: ", obstacle.position.y)
     
        let hitbox = CGSize(width: obstacle.size.width * 0.8, height: obstacle.size.height * 0.8)
        
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: hitbox)
        obstacle.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
        obstacle.physicsBody?.collisionBitMask = PhysicsCategory.Floor
        obstacle.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        obstacle.physicsBody?.affectedByGravity = false
        obstacle.physicsBody?.friction = 0.0
        obstacle.physicsBody?.restitution = 0.0
        obstacle.physicsBody?.allowsRotation = false
        obstacle.physicsBody?.angularDamping = 0.0
        obstacle.physicsBody?.linearDamping = 0.0
        obstacle.physicsBody?.mass += 1.3
        
        
        let randomX = Int(arc4random_uniform(5)) + 5
        let randomY = -Int(arc4random_uniform(7)) - 5
        obstacle.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
        self.animate()
    }
    
    override func move() {
        
        obstacle.position.x -= 2.5 * (obstacle.gameScene?.movingSpeed)!
    }
    
    func animate(){
        for i in 0...8{
            
            var textureName = ""
            textureName = "turtle\(i)"
            
            obstacle.texturesArray.append(SKTexture(imageNamed: textureName))
            obstacle.run(SKAction.repeatForever(SKAction.animate(with: obstacle.texturesArray, timePerFrame: 0.06, resize: true, restore: false)))
            obstacle.setScale(0.10)
        }
    }

}
