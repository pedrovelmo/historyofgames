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
    
    var epoch = Epoch(whatEpochIsThis: 0)
//    var currentFloors: [Floor] = []
    
    override func didMove(to view: SKView) {
        
        var background = epoch.background?[0]
        background?.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background?.zPosition = -1
        self.addChild(background!)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
 
        
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func floorManager(){
        
        for f in Floor.floorsArray{
            
            f.position.x -= 2
        }
        
        if(Floor.floorsArray.count <= 1){
                
            let newFloor = Floor(epochId: self.epoch.whatEpochIsThis!)
                
            newFloor.position = CGPoint(x: (CGFloat(Floor.floorsArray.count) * newFloor.size.width) + newFloor.size.width / 2, y: newFloor.size.height / 2)
            
            newFloor.physicsBody = SKPhysicsBody(rectangleOf: newFloor.size)
            newFloor.physicsBody?.isDynamic = false
            newFloor.physicsBody?.categoryBitMask = 1
            
            print("Posição X:" + String(describing: newFloor.position.x))
            
            self.scene?.addChild(newFloor)
            Floor.floorsArray.append(newFloor)
        }
            
        if(Floor.floorsArray[0].position.x + Floor.floorsArray[0].size.width / 2 <= 0){
                
            self.removeChildren(in: [Floor.floorsArray[0]])
            Floor.floorsArray.remove(at: 0)
        }
            
        
    }
    
    override func update(_ currentTime: TimeInterval) {
    
        // Cheap trick - Change this. How to instantiate epoch first.
        
        if(self.epoch.whatEpochIsThis != nil){
            
            floorManager()
        }
    }
}
