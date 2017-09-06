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
    
    var movingSpeed: CGFloat = 0
    
    override func didMove(to view: SKView) {
        
        self.movingSpeed = (self.scene?.size.width)! / 100
        
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
            
            f.position.x -= speed
        }
        
        // Generates new Floors
        if(Floor.floorsArray.count <= Floor.maxFloors){
                
            let newFloor = Floor(epochId: self.epoch.whatEpochIsThis!)
            
            // Width + 2 to compensate for the small space beetween floors.
            newFloor.size = CGSize(width: (self.scene?.size.width)! + 2, height: (self.scene?.size.height)! / 4)
            newFloor.position = CGPoint(x: (CGFloat(Floor.floorsArray.count) * (self.scene?.size.width)!), y: newFloor.size.height / 2)
            
            self.scene?.addChild(newFloor)
            Floor.floorsArray.append(newFloor)
        }
        
        // Respositions floors and sets their image according to the current epoch
        if(Floor.floorsArray[0].position.x + Floor.floorsArray[0].size.width / 2 <= 0){
            
           Floor.floorsArray[0].position = CGPoint(x: (CGFloat(Floor.floorsArray.count - 1) * (self.scene?.size.width)!), y: Floor.floorsArray[0].size.height / 2)
            Floor.floorsArray[0].setFloorImage(epochId: self.epoch.whatEpochIsThis!)
            
            Floor.floorsArray.rearrange(from: 0, to: Floor.floorsArray.lastIndex)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
    
        // Cheap trick - Change this. How to instantiate epoch first.
        
        if(self.epoch.whatEpochIsThis != nil){
            
            floorManager()
        }
    }
}
