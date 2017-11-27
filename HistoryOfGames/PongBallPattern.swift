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
        
        obstacle.size = CGSize(width: 10, height: 10)
        
        super.init(obstacle: obstacle)
        
        let randomPosition = arc4random_uniform(UInt32((obstacle.gameScene?.size.height)!))
        
        obstacle.position = CGPoint(x: obstacle.gameScene!.size.width + 20, y: CGFloat(CGFloat(randomPosition) +  (obstacle.gameScene?.floorPosition)!))
        
        obstacle.configPhysicsBody()
        
        obstacle.physicsBody?.mass = (obstacle.physicsBody?.mass)! * 8
    }
    
    override func move() {
        
        if(!didStartMoving){
            
            let randomX = -Double(arc4random_uniform(UInt32((obstacle.gameScene?.movingSpeed)! * 1.7))) - Double((obstacle.gameScene?.movingSpeed)!) * 1.3
            
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
