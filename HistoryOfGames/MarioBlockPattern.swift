//
//  MarioBlockPattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class MarioBlockPattern: EnemyPattern{
    
    override func startMoving(floorPosition: CGFloat, scene: SKScene) {
        
        obstacle.size = CGSize(width: 40, height: 40)
        
        obstacle.position.y = CGFloat(arc4random_uniform(UInt32(scene.size.height - obstacle.size.height / 2))) + floorPosition + obstacle.size.height / 2
        
        obstacle.position.x = scene.size.width + 20
        
        let randomMoveUp = Double(arc4random_uniform(UInt32(0.5))) + 0.5
        let randomMoveDown = Double(arc4random_uniform(UInt32(0.5))) + 0.5
        let randomMoveSideways = Double(arc4random_uniform(UInt32(0.5))) + 0.7
        
        let moveUpAction = SKAction.moveTo(y: scene.size.height - obstacle.size.height / 2, duration: randomMoveUp)
        // move down 100
        let moveDownAction = SKAction.moveTo(y: floorPosition + obstacle.size.height / 2, duration: randomMoveDown)
        
        let moveSidewaysAction = SKAction.moveBy(x: -40, y: 0, duration: randomMoveSideways)
        // sequence of moving up then down
        var jumpSequence: SKAction!
        
        jumpSequence = SKAction.sequence([moveDownAction, moveSidewaysAction, moveUpAction, moveSidewaysAction])
        
        setObstaclePhysicsBody(obstacle: obstacle)
        
        obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
    }
}
