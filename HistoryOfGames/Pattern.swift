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
    
    func startMoving(floorPosition: CGFloat, sceneHeight: CGFloat){
        
        switch self.name{
            
            case "pongBall":
                
                // TO-DO: Rearrange this size setting
                obstacle.size = CGSize(width: 10, height: 10)
                
                obstacle.physicsBody?.affectedByGravity = false
                obstacle.physicsBody?.friction = 0.0
                obstacle.physicsBody?.restitution = 1.0
                obstacle.physicsBody?.allowsRotation = false
                obstacle.physicsBody?.angularDamping = 0.0
                obstacle.physicsBody?.linearDamping = 0.0
            
                obstacle.physicsBody?.applyImpulse(CGVector(dx: -11, dy: -9))
            
            case "pongBar":
                obstacle.size = CGSize(width: 10, height: 50)
               
                obstacle.physicsBody?.affectedByGravity = false
                obstacle.physicsBody?.friction = 0.0
                obstacle.physicsBody?.restitution = 1.0
                obstacle.physicsBody?.allowsRotation = false
                obstacle.physicsBody?.angularDamping = 0.0
                obstacle.physicsBody?.linearDamping = 0.0
                
                let moveSidewaysAction = SKAction.moveTo(x: -30, duration: 1.0)
                let moveUpAction = SKAction.moveTo(y: sceneHeight, duration: 0.4)
                // move down 100
                let moveDownAction = SKAction.moveTo(y: floorPosition + obstacle.size.height / 2, duration:0.5)
                // sequence of moving up then down
                let jumpSequence = SKAction.sequence([moveUpAction, moveDownAction])
                obstacle.run(moveSidewaysAction)
                obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
            
            default:
                break
            
        }
    }
}
