//
//  PongBallPattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class PongBallPattern: EnemyPattern{
    
    var didStartMoving = false
    
    override init(obstacle: Obstacle) {
        
        obstacle.size = CGSize(width: obstacle.getGameScene().size.width * 0.02, height: obstacle.getGameScene().size.height * 0.032)
        
        super.init(obstacle: obstacle)
        
        let randomPosition = arc4random_uniform(UInt32((obstacle.getGameScene().size.height)))
        
        obstacle.position = CGPoint(x: obstacle.getGameScene().size.width + 20, y: CGFloat(CGFloat(randomPosition) +  (obstacle.getGameScene().floorPosition)!))
        
        obstacle.configPhysicsBody()
        
        obstacle.physicsBody?.mass = (obstacle.physicsBody?.mass)! * 8
    }
    
    override func move() {
        
        if(!didStartMoving){
            let randomX: Double!
            if UIDevice.current.userInterfaceIdiom == .pad {
                randomX = -Double(arc4random_uniform(UInt32((obstacle.getGameScene().movingSpeed) * 7.0))) - Double((obstacle.getGameScene().movingSpeed)) * 5.0
            }
                
            else {
                 randomX = -Double(arc4random_uniform(UInt32((obstacle.getGameScene().movingSpeed) * 2.0))) - Double((obstacle.getGameScene().movingSpeed)) * 1.5
            }
            
            
            var randomY: Double!
            let yType = arc4random_uniform(2)
            if (yType == 0) {
                randomY = -randomX
            }
                
            else {
                
                randomY = randomX
            }
            
            obstacle.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
            didStartMoving = true
        }
    }
}
