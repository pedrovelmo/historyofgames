//
//  Pattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 04/09/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class Pattern{
    
    var obstacle: Obstacle
    
    var name: String
    
    init(name: String, obstacle: Obstacle) {
        
        self.name = name
        self.obstacle = obstacle
    }
    
    func startMoving(floorPosition: CGFloat, scene: SKScene){
        
        switch self.name{
            
            case "pongBall":
                
                // TO-DO: Rearrange this size setting
                obstacle.size = CGSize(width: 10, height: 10)
                
                let randomPosition = arc4random_uniform(UInt32(scene.size.height))
                
                obstacle.position = CGPoint(x: scene.size.width + 20, y: CGFloat(CGFloat(randomPosition) + floorPosition))
                
                obstacle.configPhysicsBody()
                
                obstacle.physicsBody?.affectedByGravity = false
                obstacle.physicsBody?.friction = 0.0
                obstacle.physicsBody?.restitution = 1.0
                obstacle.physicsBody?.allowsRotation = false
                obstacle.physicsBody?.angularDamping = 0.0
                obstacle.physicsBody?.linearDamping = 0.0
                
                obstacle.physicsBody?.mass = (obstacle.physicsBody?.mass)! * 8
                obstacle.physicsBody?.applyImpulse(CGVector(dx: -11, dy: -9))
            
            case "pongBar":
                obstacle.size = CGSize(width: 10, height: 50)
                
                let randomPosition = Int(arc4random_uniform(2))
                
                let moveUpAction = SKAction.moveTo(y: scene.size.height - obstacle.size.height / 2, duration: 1.5)
                // move down 100
                let moveDownAction = SKAction.moveTo(y: floorPosition + obstacle.size.height / 2, duration:1.5)
                // sequence of moving up then down
                var jumpSequence: SKAction!
                
                if(randomPosition == 0){
                    
                    obstacle.position.y = floorPosition + obstacle.size.height / 2
                     jumpSequence = SKAction.sequence([moveUpAction, moveDownAction])
                }
                else{
                    obstacle.position.y = scene.size.height - obstacle.size.height / 2
                     jumpSequence = SKAction.sequence([moveDownAction, moveUpAction])
                }
                
                obstacle.position.x = scene.size.width + 20
               
                obstacle.configPhysicsBody()
                
                obstacle.physicsBody?.affectedByGravity = false
                obstacle.physicsBody?.friction = 0.0
                obstacle.physicsBody?.restitution = 1.0
                obstacle.physicsBody?.allowsRotation = false
                obstacle.physicsBody?.angularDamping = 0.0
                obstacle.physicsBody?.linearDamping = 0.0

                obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
            
            default:
                break
        }
    }
}
