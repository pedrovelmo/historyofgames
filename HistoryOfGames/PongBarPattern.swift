//
//  PongBarPattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class PongBarPattern: EnemyPattern{
    
    override init(obstacle: Obstacle) {
        
        obstacle.size = CGSize(width: 10, height: 50)
        
        obstacle.position.x = (obstacle.gameScene?.size.width)! + 20
        
        super.init(obstacle: obstacle)
        
        let randomPosition = Int(arc4random_uniform(2))
        let randomDuration = Double(arc4random_uniform(UInt32(1.5))) + 1.2
        let moveUpAction = SKAction.moveTo(y: (obstacle.gameScene?.size.height)! - obstacle.size.height / 2, duration: TimeInterval(randomDuration))
        // move down 100
        let moveDownAction = SKAction.moveTo(y: (obstacle.gameScene?.floorPosition)! + obstacle.size.height / 2, duration: TimeInterval(randomDuration))
        // sequence of moving up then down
        var jumpSequence: SKAction!
        
        if(randomPosition == 0){
            
            obstacle.position.y = (obstacle.gameScene?.floorPosition)! + obstacle.size.height / 2
            jumpSequence = SKAction.sequence([moveUpAction, moveDownAction])
        }
        else{
            obstacle.position.y = (obstacle.gameScene?.size.height)! - obstacle.size.height / 2
            jumpSequence = SKAction.sequence([moveDownAction, moveUpAction])
        }
        
        obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
        
       obstacle.configPhysicsBody()
    }
    
    override func move() {
        
        obstacle.position.x -= (obstacle.gameScene?.movingSpeed)!
    }
}
