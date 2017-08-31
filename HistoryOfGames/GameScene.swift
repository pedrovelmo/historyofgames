//
//  GameScene.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 31/08/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    

    override func didMove(to view: SKView) {
        
        var epoch = Epoch(whatEpochIsThis: 1)
        var floor = epoch.floors?[0]
        floor?.position = CGPoint(x: (floor?.size.width)! / 2, y: (floor?.size.height)! / 2)
        floor?.zPosition = 2
        self.addChild(floor!)
        
        var background = epoch.background?[0]
        background?.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background?.zPosition = 1
        self.addChild(background!)
 
           }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
 
        
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    
       
    }
}
