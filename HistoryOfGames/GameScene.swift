//
//  GameScene.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 31/08/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var epoch = Epoch(whatEpochIsThis: 0)
    
    var player = Player(name: "pennywise")
    
    var movingSpeed: CGFloat = 0
    
    var jumpCounter = 0
    
    var backgroundSound : BackgroundMusic = .CarminaBurana
    
     let jumpMusic = SKAudioNode(fileNamed: "spin_jump.mp3")
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -30)
        
        self.movingSpeed = (self.scene?.size.width)! / 100
        
        var background = epoch.background?[0]
        background?.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background?.zPosition = -1
        self.addChild(background!)
        
        // Add first floor
        var floor = Floor(epochId: self.epoch.whatEpochIsThis!)
        // Width + 2 to compensate for the small space beetween floors.
        floor.size = CGSize(width: (self.scene?.size.width)! + 2, height: (self.scene?.size.height)! / 4)
        floor.position = CGPoint(x: (CGFloat(Floor.floorsArray.count) * (self.scene?.size.width)!), y: floor.size.height / 2)
        
        self.scene?.addChild(floor)
        Floor.floorsArray.append(floor)
        
        player.position.x = (self.scene?.size.width)! / 50 + player.size.width / 2
        player.position.y = floor.size.height 
        self.scene?.addChild(player)
        
        // Background Music configuration
        var fileName: String?
        
        switch(backgroundSound) {
        case .HappyFunk:
            fileName = "HappyFunk.mp3"
            
        case .CarminaBurana:
            fileName = "CarminaBurana.mp3"
            
        case .SpaceGroove:
            fileName = "SpaceGroove.mp3"
            
        case .AdventureTune:
            fileName = "AdventureTune.mp3"
        }
        let backgroundMusic = SKAudioNode(fileNamed: fileName!)
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        jumpCounter = jumpCounter + 1
 
        if (jumpCounter <= player.maxJumps) {
        player.jump()
        self.run(SKAction.playSoundFileNamed("spin_jump.mp3", waitForCompletion: false))
            
        }
        
        else {
            jumpCounter = 0
        }
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
        
            floorManager()

    }
}
