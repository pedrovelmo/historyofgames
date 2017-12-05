//
//  Player.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 31/08/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import UIKit
import SpriteKit


class Player: SKSpriteNode {
    
    private var characterName: String
    private var texturesArray =  [SKTexture]()
    private var maxJumps = 2 
    private var defaultPlayerX: CGFloat = 0
    private var toTheRight = false
    private var toTheLeft = false
    var gameScene: GameScene?
    
    // TO-DO: Define image name pattern and update init
    init(name: String, gameScene: GameScene) {
        self.characterName = name
        self.gameScene = gameScene
       

        var texture: SKTexture = SKTexture(imageNamed: "dido1")
        super.init(texture: texture, color: UIColor.clear, size: (texture.size()))
        switch characterName {
        case "dido":
            
            for i in 1...7{
                
                var textureName = ""
                
                textureName = "dido\(i)"
                
                texturesArray.append(SKTexture(imageNamed: textureName))
            }
            
            texture = SKTexture(imageNamed: "dido1")
            self.setScale(gameScene.size.height * 0.0005)
            
        case "odessa":
            for i in 1...9{
                
                var textureName = ""
                
                textureName = "odessaRunframe\(i)"
                
                texturesArray.append(SKTexture(imageNamed: textureName))
            }
            
            texture = SKTexture(imageNamed: "odessaRunframe1")
            self.setScale(gameScene.size.height * 0.0012)
            
        case "kingArth":
            for i in 1...13{
                
                var textureName = ""
                
                textureName = "KingArth\(i)"
                
                texturesArray.append(SKTexture(imageNamed: textureName))
            }
            
            texture = SKTexture(imageNamed: "KingArth1")
            self.setScale(gameScene.size.height * 0.0005)
            
        case "lumos":
            for i in 1...8{
                
                var textureName = ""
                
                textureName = "LumosWalking\(i)"
                
                texturesArray.append(SKTexture(imageNamed: textureName))
                self.setScale(gameScene.size.height * 0.0025)
            }
            
            texture = SKTexture(imageNamed: "LumosWalking")
            
            
            
        default:
            break
        }
        
       
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func getToTheRight() -> Bool {
        return self.toTheRight
    }
    
    func setToTheRight(value: Bool) {
        self.toTheRight = value
    }
    
    func getToTheLeft() -> Bool {
        return self.toTheLeft
    }
    
    func setToTheLeft(value: Bool) {
        self.toTheLeft = value
    }
    
    func getDefaultPlayerX() -> CGFloat {
        return self.defaultPlayerX
    }
    
    func setDefaultPlayerX(scene: SKScene){
        
        self.defaultPlayerX = (scene.size.width) / 8 + self.size.width / 2
    }
    
    func getMaxJumps() -> Int {
        return self.maxJumps
    }
    
    func setMaxJumps(value: Int) {
        self.maxJumps = value
        
    }
    
    func setPhysicsBody() {
        
        let hitbox: CGSize!
        if (characterName == "odessa") {
            hitbox = CGSize(width: self.size.width * 0.3, height: self.size.height * 0.35)
        }
        
        else if (characterName == "kingArth") {
            hitbox = CGSize(width: self.size.width * 0.6, height: self.size.height * 0.85)
        }
            
        else if (characterName == "lumos") {
            hitbox = CGSize(width: self.size.width * 0.1, height: self.size.height * 0.15)
        }
        else {
        hitbox = CGSize(width: self.size.width * 0.6, height: self.size.height * 0.9)
        }
        self.physicsBody = SKPhysicsBody(rectangleOf: hitbox)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player
        self.physicsBody?.collisionBitMask = PhysicsCategory.Floor
        self.physicsBody?.mass *= 1.3
    }
    
    func startAnimation() {
        self.run(SKAction.repeatForever(SKAction.animate(with: self.texturesArray, timePerFrame: 0.1, resize: true, restore: false)))
    }
    
    func jump(jumpCount: Int){
        
        if(jumpCount <= self.maxJumps){
           
            self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            if UIDevice.current.userInterfaceIdiom == .pad {
                if (characterName == "dido") {
            self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: ((gameScene?.size.height)! * 1.3)))
                }
                
                else if (characterName == "odessa") {
                    self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: ((gameScene?.size.height)! * 1.6)))
                }
                
                else if (characterName == "kingArth") {
                    self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: ((gameScene?.size.height)! * 1.6)))
                }
                
                else if (characterName == "lumos") {
                    self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: ((gameScene?.size.height)! * 1.1)))
                }
            }
            
            else {
                if (characterName == "dido") {
                self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 110))
                }
                
                else if (characterName == "kingArth") {
                    self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 140))
                }
                
                else if (characterName == "odessa") {
                    self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
                }
                
                else if (characterName == "lumos") {
                    self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 90))
                }
                
                
            }
        }
    }
}
