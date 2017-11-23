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
            UInt32((obstacle.gameScene?.size.height)! * 0.3))) + (obstacle.gameScene?.size.height)! * 0.7
        
        
        obstacle.position.y = randomY
        
        obstacle.position.x = (obstacle.gameScene?.size.width)! + 20
        
//        let randomMoveDown = Double(arc4random_uniform(UInt32(0.3))) + 0.7
//        let randomMoveSideways = Double(arc4random_uniform(UInt32(0.3))) + 0.8
//        let randomQuantityDown = CGFloat(arc4random_uniform(UInt32(4))) + 1
//        let randomQuantitySide = Int(arc4random_uniform(UInt32(40))) + 20

        // move down 100
        let moveDownAction = SKAction.moveBy(x: 0, y: -((obstacle.gameScene?.size.height)! / 5), duration: 0.5)

        let moveSidewaysAction = SKAction.moveBy(x: CGFloat(-30), y: 0, duration: 0.5)
       
        // sequence of moving up then down
        var jumpSequence: SKAction!

        jumpSequence = SKAction.sequence([moveDownAction, moveSidewaysAction])
        
        obstacle.configPhysicsBody()
        
        obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
    }
    
    override func move() {
        
        obstacle.position.x -= ((obstacle.gameScene?.movingSpeed)! * 0.9)
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
        
            
            obstacle.texturesArray.append(SKTexture(imageNamed: textureName))
            obstacle.run(SKAction.repeatForever(SKAction.animate(with: obstacle.texturesArray, timePerFrame: 0.15, resize: true, restore: false)))
            obstacle.setScale(0.4)
        }
    }
}
