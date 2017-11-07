//
//  PacmanRedGhostPattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class PacmanGhostPattern: EnemyPattern{
    
    var randomWidth: CGFloat?
    var randomHeight: CGFloat?
    var sinSignal: Int?
    
    override init(obstacle: Obstacle) {
        
        super.init(obstacle: obstacle)
        
        let randomImage = arc4random_uniform(5)
        
        self.obstacle.texture = SKTexture(imageNamed: "ghost" + String(randomImage))
        
        obstacle.size = CGSize(width: 30, height: 30)
        
        obstacle.position.x = (obstacle.gameScene?.size.width)! + 20
        obstacle.configPhysicsBody()
        
        randomWidth = CGFloat((UInt32(arc4random_uniform(8))) + 3)
        randomHeight = randomBetweenNumbers(firstNum: 0.25, secondNum: 0.3)
        
        let randomSignal = arc4random_uniform(2)
        if (randomSignal == 0) {
            sinSignal = 1
        }
        
        else {
            sinSignal = -1
        }
    }
    
    override func move() {
        let height = randomHeight! * ((obstacle.gameScene?.size.height)!  - (obstacle.gameScene?.floorPosition)!)
        
        let width = (obstacle.gameScene?.size.width)! / randomWidth!

        obstacle.position.x -= (obstacle.gameScene?.movingSpeed)! * 1.2
        
        obstacle.position.y = CGFloat(sinSignal!) * sin(obstacle.position.x / width)
        obstacle.position.y = obstacle.position.y * height + (obstacle.gameScene?.size.height)! / 2

    }
   
}


func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
    return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
}




