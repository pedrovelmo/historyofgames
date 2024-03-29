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

        let randomPositionY = CGFloat(arc4random_uniform(UInt32((obstacle.getGameScene().size.height))))
        
        obstacle.position = CGPoint(x: (obstacle.getGameScene().size.width) / 2 + obstacle.size.width / 6, y: 0
        )
        
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
        obstacle.physicsBody?.linearDamping = 0.9
        obstacle.physicsBody?.mass = 0.01
        
        let movePath = UIBezierPath(
                        arcCenter: CGPoint(x:obstacle.getGameScene().size.width / 2,
                        y:obstacle.getGameScene().floorPosition!),
                        radius:  obstacle.getGameScene().size.height / 2,
                        startAngle: CGFloat(Double.pi / 2),
                        endAngle: CGFloat(Double.pi), clockwise: true
        )
        
        let moveArc = SKAction.follow(movePath.cgPath, asOffset: true,
                                      orientToPath: false, duration: 0.6)
        
        let moveLeft = SKAction.move(to: CGPoint(x: -obstacle.getGameScene().size.width, y: obstacle.position.y), duration: 1.25)
        
        let moveActions = SKAction.sequence([moveArc, moveLeft])
        
        obstacle.run(moveActions)
        
        self.animate()
    }
    
    override func move() {

    }
    
    func animate(){
        for i in 0...8{
            
            var textureName = ""
            textureName = "turtle\(i)"
            
            obstacle.appendItemInTexturesArray(value: SKTexture(imageNamed: textureName))
            obstacle.run(SKAction.repeatForever(SKAction.animate(with: obstacle.getTexturesArray(), timePerFrame: 0.06, resize: true, restore: false)))
            obstacle.setScale(obstacle.getGameScene().size.height * 0.0003)
        }
    }
}
