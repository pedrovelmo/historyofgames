//
//  MarioBlockPattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class MarioBlockPattern: EnemyPattern{
    
    override init(obstacle: Obstacle) {
        
        super.init(obstacle: obstacle)
        
        let randomImage = arc4random_uniform(4) + 1
        
        obstacle.texture = SKTexture(imageNamed: "block" + String(randomImage))
        
        obstacle.size = CGSize(width: obstacle.getGameScene().size.width * 0.085, height: obstacle.getGameScene().size.height * 0.1)
        
        obstacle.position.y = CGFloat(arc4random_uniform(UInt32((obstacle.getGameScene().size.height) - obstacle.size.height / 2))) + (obstacle.getGameScene().floorPosition)! + obstacle.size.height / 2
        
        obstacle.position.x = (obstacle.getGameScene().size.width) + 20
        
        let randomMoveUp = Double(arc4random_uniform(UInt32(0.5))) + 0.5
        let randomMoveDown = Double(arc4random_uniform(UInt32(0.5))) + 0.5
        let randomMoveSideways = Double(arc4random_uniform(UInt32(0.5))) + 0.5
        
        let moveUpAction = SKAction.moveTo(y: (obstacle.getGameScene().size.height) - obstacle.size.height / 2, duration: randomMoveUp)
        // move down 100
        let moveDownAction = SKAction.moveTo(y: (obstacle.getGameScene().floorPosition!) + obstacle.size.height / 2, duration: randomMoveDown)
        
            

        let shakeAction = SKAction.rotate(byAngle: CGFloat(3.14/4), duration: 0.2)
        let shakeAction1 = SKAction.rotate(toAngle: CGFloat(0), duration: 0.2)
        let moveSidewaysAction = SKAction.sequence([SKAction.moveBy(x: -30, y: 0, duration: randomMoveSideways),shakeAction,shakeAction.reversed(), shakeAction1])
        

        
        // sequence of moving up then down
        var jumpSequence: SKAction!
        let randomSequence = arc4random_uniform(2)
        if (randomSequence == 0) {
        
        jumpSequence = SKAction.sequence([moveDownAction, moveSidewaysAction, moveUpAction, moveSidewaysAction])
            
        }
        
        else {
                    jumpSequence = SKAction.sequence([moveUpAction, moveSidewaysAction, moveDownAction, moveSidewaysAction])
        }
        
        obstacle.configPhysicsBody()
        obstacle.physicsBody?.allowsRotation = true
        
        obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
    }
    
    override func move() {
        
        obstacle.position.x -= (obstacle.getGameScene().movingSpeed)
    }
}
