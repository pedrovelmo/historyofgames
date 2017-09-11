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
    
    func startMoving(){
        
        switch self.name{
            
            case "pongBall":
                
                // TO-DO: Rearrange this size setting
                obstacle.size = CGSize(width: 20, height: 20)
                
                obstacle.physicsBody?.affectedByGravity = false
                obstacle.physicsBody?.friction = 0.0
                obstacle.physicsBody?.restitution = 1.0
                obstacle.physicsBody?.allowsRotation = false
                obstacle.physicsBody?.categoryBitMask = 2
                obstacle.physicsBody?.angularDamping = 0.0
                obstacle.physicsBody?.linearDamping = 0.0
            
                obstacle.physicsBody?.applyImpulse(CGVector(dx: -11, dy: -9))
            
            default:
                break
            
        }
    }
}
