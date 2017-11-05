//
//  PongBarPattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class PongBarPattern: EnemyPattern{
    
    override func startMoving(floorPosition: CGFloat, scene: SKScene) {
        
        obstacle.size = CGSize(width: 10, height: 50)
        
        let randomPosition = Int(arc4random_uniform(2))
        let randomDuration = Double(arc4random_uniform(UInt32(1.5))) + 1.2
        let moveUpAction = SKAction.moveTo(y: scene.size.height - obstacle.size.height / 2, duration: TimeInterval(randomDuration))
        // move down 100
        let moveDownAction = SKAction.moveTo(y: floorPosition + obstacle.size.height / 2, duration: TimeInterval(randomDuration))
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
        setObstaclePhysicsBody(obstacle: obstacle)
        
        obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
    }
}
