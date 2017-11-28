//
//  ZeldaCrazyLinkPattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 23/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class ZeldaCrazyLinkPattern: EnemyPattern{
    
    var sword: Obstacle?
    
    override init(obstacle: Obstacle) {
        super.init(obstacle: obstacle)
        
        self.obstacle.setScale(0.15)
        
        obstacle.position = CGPoint(x: obstacle.getGameScene().size.width + 20,
                                    y: (obstacle.getGameScene().floorPosition)! + obstacle.size.height / 2)
        
        obstacle.configPhysicsBody()
        
        let waitBeforeThrowingSword = SKAction.wait(forDuration: 0.3)
        
        let throwSword = SKAction.run {
            
            self.sword = Obstacle(name: "crazyAssLinkSword",
                                  scene: self.obstacle.getGameScene())
            
            self.sword?.position = CGPoint(
                x: self.obstacle.position.x - (self.sword?.size.width)! / 2,
                y: self.obstacle.position.y)
            
            Obstacle.obstaclesArray.append(self.sword!)
            obstacle.getGameScene().addChild(self.sword!)
        }
        
        let waitAndThrow = SKAction.sequence([waitBeforeThrowingSword, throwSword])
        
        obstacle.run(waitAndThrow)
    }
    
    override func move() {
        
        obstacle.position.x -= (obstacle.getGameScene().movingSpeed)
    }
}
