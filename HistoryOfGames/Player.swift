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
    
    var characterName: String
    var texturesArray =  [SKTexture]()
    var maxJumps = 2
    var defaultPlayerX: CGFloat = 0
    var toTheRight = false
    var toTheLeft = false
    
    // TO-DO: Define image name pattern and update init
    init(name: String) {
        self.characterName = name
       
        for i in 1...7{
            
            var textureName = ""
            
            textureName = "dido\(i)"
            
            texturesArray.append(SKTexture(imageNamed: textureName))
        }
        
        let texture = SKTexture(imageNamed: "dido1")
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.setScale(0.15)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDefaultX(scene: SKScene){
        
        self.defaultPlayerX = (scene.size.width) / 8 + self.size.width / 2
    }
    
    func setPhysicsBody() {
        
        let hitbox = CGSize(width: self.size.width * 0.6, height: self.size.height * 0.9)
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
            self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
        }
    }
}
