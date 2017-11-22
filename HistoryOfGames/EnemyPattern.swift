//
//  Pattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 04/09/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class EnemyPattern{
    
    var obstacle: Obstacle
    
    init(obstacle: Obstacle) {
        
        self.obstacle = obstacle
    }
    
    func move(){
        
        
    }
    
    func checkPosition() {
        
        for o in Obstacle.obstaclesArray{
            if o.position.x + o.size.width / 2 <= 0 {
                o.removeFromParent()
            }
            
        }
    }
    
}
