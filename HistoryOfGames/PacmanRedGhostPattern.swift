//
//  PacmanRedGhostPattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class PacmanRedGhostPattern: EnemyPattern{
    
    override init(obstacle: Obstacle) {
        
        super.init(obstacle: obstacle)
        obstacle.size = CGSize(width: 30, height: 30)
        
        let randomPosition = Int(arc4random_uniform(2))
        
        
       // let moveDiagonalUpActionFast = SKAction.moveTo(y: height * 0.8, duration: 0.5)
        
       // let moveDiagonalUpActionSlow = SKAction.moveTo(y: height * 0.9, duration: 0.9)
//
//        let moveDiagonalUpAction = SKAction.moveTo(y: height * 0.8, duration: 0.5)
//
//        let moveDiagonalDownAction = SKAction.moveTo(y: (obstacle.gameScene?.floorPosition)! * 1.5 + obstacle.size.height / 2 , duration: 0.75)
//
//
//        // sequence of moving up then down
//        var moveSequence: SKAction!
//
        if(randomPosition == 0){

            obstacle.position.y = (obstacle.gameScene?.floorPosition)! + obstacle.size.height / 2
            //moveSequence = SKAction.sequence([moveDiagonalUpAction, moveDiagonalDownAction])
        }
        else{
            obstacle.position.y = (obstacle.gameScene?.size.height)! - obstacle.size.height / 2
            //moveSequence = SKAction.sequence([moveDiagonalDownAction,  moveDiagonalUpAction])
        }
        
        obstacle.position.x = (obstacle.gameScene?.size.width)! + 20
        setObstaclePhysicsBody(obstacle: obstacle)
        
      //  obstacle.run(SKAction.repeatForever(SKAction.sequence([moveSequence])))
    }
    
    override func move() {
       let height = ((obstacle.gameScene?.size.height)!  - (obstacle.gameScene?.floorPosition)! / 2)

        let width = (obstacle.gameScene?.size.width)! / 7

        obstacle.position.x -= (obstacle.gameScene?.movingSpeed)!
        obstacle.position.y = sin(obstacle.position.x / width) * height

    }
   
}




