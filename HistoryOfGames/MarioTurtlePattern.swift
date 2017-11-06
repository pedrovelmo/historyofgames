//
//  TurtlePattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class MarioTurtlePattern: EnemyPattern{
    
    var didStartMoving = false
    
    override init(obstacle: Obstacle) {
        
        super.init(obstacle: obstacle)
        
        obstacle.position.y = CGFloat(arc4random_uniform(UInt32((obstacle.gameScene?.size.height)! - obstacle.size.height / 2))) + (obstacle.gameScene?.floorPosition!)!
        
        obstacle.position.x = (obstacle.gameScene?.size.width)! + 20
        
        // obstacle.physicsBody?.affectedByGravity = true
        
        self.animate()
    }
    
    override func move() {
        
        if(!didStartMoving){
            
            //Check this. It's dumb.
            
            let randomX = Int(arc4random_uniform(5)) + 5
            let randomY = -Int(arc4random_uniform(7)) - 5
            setObstaclePhysicsBody(obstacle: obstacle)
            obstacle.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
            obstacle.physicsBody?.restitution = 0.0
            
            didStartMoving = true
        }
        
        obstacle.position.x -= 2.5 * (obstacle.gameScene?.movingSpeed)!
    }
    
    func animate(){
        
        for i in 0...8{
            
            var textureName = ""
            
            textureName = "turtle\(i)"
            
            obstacle.texturesArray.append(SKTexture(imageNamed: textureName))
            
            obstacle.run(SKAction.repeatForever(SKAction.animate(with: obstacle.texturesArray, timePerFrame: 0.06, resize: true, restore: false)))
            
            //obstacle.size = CGSize(width: 40, height: 40)
            obstacle.setScale(0.10)
        }
    }

}
