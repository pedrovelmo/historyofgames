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
        
        obstacle.size = CGSize(width: 40, height: 40)
        
        obstacle.position.y = CGFloat(arc4random_uniform(UInt32((obstacle.gameScene?.size.height)! - obstacle.size.height / 2))) + (obstacle.gameScene?.floorPosition)! + obstacle.size.height / 2
        
        obstacle.position.x = (obstacle.gameScene?.size.width)! + 20
        
        let randomMoveUp = Double(arc4random_uniform(UInt32(0.5))) + 0.5
        let randomMoveDown = Double(arc4random_uniform(UInt32(0.5))) + 0.5
        let randomMoveSideways = Double(arc4random_uniform(UInt32(0.5))) + 0.7
        
        let moveUpAction = SKAction.moveTo(y: (obstacle.gameScene?.size.height)! - obstacle.size.height / 2, duration: randomMoveUp)
        // move down 100
        let moveDownAction = SKAction.moveTo(y: (obstacle.gameScene?.floorPosition!)! + obstacle.size.height / 2, duration: randomMoveDown)
        
        let moveSidewaysAction = SKAction.moveBy(x: -40, y: 0, duration: randomMoveSideways)
        // sequence of moving up then down
        var jumpSequence: SKAction!
        
        jumpSequence = SKAction.sequence([moveDownAction, moveSidewaysAction, moveUpAction, moveSidewaysAction])
        
        setObstaclePhysicsBody(obstacle: obstacle)
        
        obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
    }
    
    override func move() {
        
        obstacle.position.x -= (obstacle.gameScene?.movingSpeed)!
    }
}
