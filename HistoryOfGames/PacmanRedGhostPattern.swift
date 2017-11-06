//
//  PacmanRedGhostPattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class PacmanRedGhostPattern: EnemyPattern{
    
    override func startMoving(floorPosition: CGFloat, scene: SKScene) {
        
        obstacle.size = CGSize(width: 30, height: 30)
        
        let randomPosition = Int(arc4random_uniform(2))
        
        let height = scene.size.height  - obstacle.size.height / 2
        
        let moveDiagonalUpActionFast = SKAction.moveTo(y: height * 0.8, duration: 0.5)
        
        let moveDiagonalUpActionSlow = SKAction.moveTo(y: height * 0.9, duration: 0.9)
        
        
        let moveDiagonalDownAction = SKAction.moveTo(y: floorPosition * 1.5 + obstacle.size.height / 2 , duration: 0.75)
        
        
        // sequence of moving up then down
        var moveSequence: SKAction!
        
        if(randomPosition == 0){
            
            obstacle.position.y = floorPosition + obstacle.size.height / 2
            moveSequence = SKAction.sequence([moveDiagonalUpActionFast, moveDiagonalUpActionSlow, moveDiagonalDownAction])
        }
        else{
            obstacle.position.y = scene.size.height - obstacle.size.height / 2
            moveSequence = SKAction.sequence([moveDiagonalDownAction, moveDiagonalUpActionFast, moveDiagonalUpActionSlow])
        }
        
        obstacle.position.x = scene.size.width + 20
        setObstaclePhysicsBody(obstacle: obstacle)
        
        obstacle.run(SKAction.repeatForever(SKAction.sequence([moveSequence])))
    }
}
