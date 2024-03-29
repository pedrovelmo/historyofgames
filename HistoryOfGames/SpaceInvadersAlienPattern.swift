//
//  SpaceInvadersAlienPattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class SpaceInvadersAlienPattern: EnemyPattern{
    
    override init(obstacle: Obstacle) {
        
        super.init(obstacle: obstacle)
        
        let randomImage = arc4random_uniform(2)
        self.animate(type: randomImage)
        
        let randomY = CGFloat(arc4random_uniform(
            UInt32((obstacle.getGameScene().size.height) * 0.3))) + (obstacle.getGameScene().size.height) * 0.7
        
        obstacle.position.y = randomY
        
        obstacle.position.x = (obstacle.getGameScene().size.width) + 20

        let moveDownAction: SKAction
        
        if(obstacle.getGameScene().epoch.getWhatEpochIsThis() == 0){
            
            moveDownAction = SKAction.moveBy(x: 0, y: -((obstacle.getGameScene().size.height) / 5), duration: 1.0)
        }
        
        else{
            
             moveDownAction = SKAction.moveBy(x: 0, y: -((obstacle.getGameScene().size.height) / 5), duration: 0.5)
        }

        let moveSidewaysAction = SKAction.moveBy(x: CGFloat(-30), y: 0, duration: 0.5)
       
        // sequence of moving up then down
        var jumpSequence: SKAction!
        
        jumpSequence = SKAction.sequence([moveDownAction, moveSidewaysAction])
        
        obstacle.configPhysicsBody()
        
        obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
    }
    
    override func move() {
        
        obstacle.position.x -= ((obstacle.getGameScene().movingSpeed) * 0.9)
    }
    
    func animate(type: UInt32){
        var textureName = ""
        for i in 0...1{
            if (type == 0) {
            
            textureName = "alien1-\(i)"
            }
                
            else if (type == 1) {
            
            textureName = "alien2-\(i)"
        }
        
            obstacle.appendItemInTexturesArray(value: SKTexture(imageNamed: textureName))
            obstacle.run(SKAction.repeatForever(SKAction.animate(with: obstacle.getTexturesArray(), timePerFrame: 0.15, resize: true, restore: false)))
            obstacle.setScale(obstacle.getGameScene().size.height * 0.0011)
        }
    }
}
