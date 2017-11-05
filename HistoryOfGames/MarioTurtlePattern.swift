//
//  TurtlePattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class MarioTurtlePattern: EnemyPattern{
    
    override func startMoving(floorPosition: CGFloat, scene: SKScene) {
        
        for i in 0...8{
            
            var textureName = ""
            
            textureName = "turtle\(i)"
            
            let texture = SKTexture(imageNamed: textureName)
            
            obstacle.texturesArray.append(SKTexture(imageNamed: textureName))
        }
        
            obstacle.run(SKAction.repeatForever(SKAction.animate(with: obstacle.texturesArray, timePerFrame: 0.06, resize: true, restore: false)))
            //obstacle.size = CGSize(width: 40, height: 40)
            obstacle.setScale(0.10)
            obstacle.position.y = CGFloat(arc4random_uniform(UInt32(scene.size.height - obstacle.size.height / 2))) + floorPosition
        
            obstacle.position.x = scene.size.width + 20
            let randomX = Int(arc4random_uniform(5)) + 5
            let randomY = -Int(arc4random_uniform(7)) - 5
            setObstaclePhysicsBody(obstacle: obstacle)
            obstacle.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
            obstacle.physicsBody?.restitution = 0.0
        
           // obstacle.physicsBody?.affectedByGravity = true
    }
}
