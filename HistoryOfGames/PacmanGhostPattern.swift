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
        
        obstacle.size = CGSize(width: obstacle.getGameScene().size.width * 0.07, height: obstacle.getGameScene().size.height * 0.075)
        
        obstacle.position.x = (obstacle.getGameScene().size.width) + 20
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
        let height = randomHeight! * ((obstacle.getGameScene().size.height)  - (obstacle.getGameScene().floorPosition)!)
        
        let width = (obstacle.getGameScene().size.width) / randomWidth!

        obstacle.position.x -= (obstacle.getGameScene().movingSpeed) * 1.2
        
        obstacle.position.y = CGFloat(sinSignal!) * sin(obstacle.position.x / width * 0.75)
        obstacle.position.y = obstacle.position.y * height + (obstacle.getGameScene().size.height) / 2
    }
}


func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
    return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
}




