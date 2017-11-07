//
//  Player.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 31/08/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import UIKit
import SpriteKit

enum stateTypes: Int {
    case running = 0
    case jumping = 1
    case dying = 2
}

class Player: SKSpriteNode {
    
    var characterName: String
    var state: Int
    var imageVector: [Int : UIImage] = [ : ]
    var texturesArray =  [SKTexture]()
    var ability : Ability?
    var maxJumps = 2
    
    var defaultPlayerX: CGFloat = 0
    var toTheRight = false
    var toTheLeft = false
    
    // TO-DO: Define image name pattern and update init
    init(name: String) {
        self.characterName = name
        self.state = stateTypes.running.rawValue
        
        /*
        for i in 0...23{
            
            var textureName = ""
            
            if i<=9{
                textureName = "running 2_00\(i)"
            } else {
                textureName = "running 2_0\(i)"
            }
            
            texturesArray.append(SKTexture(imageNamed: textureName))
            
        }
        print(texturesArray.count)

        let texture = SKTexture(imageNamed: name)
        */
        
        for i in 1...7{
            
            var textureName = ""
            
            textureName = "dido\(i)"
            
            let texture = SKTexture(imageNamed: textureName)
            
            texturesArray.append(SKTexture(imageNamed: textureName))
            
        }
        
        let texture = SKTexture(imageNamed: "dido1")
        
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.setScale(0.15)
        setAbility()

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDefaultX(scene: SKScene){
        
        self.defaultPlayerX = (scene.size.width) / 8 + self.size.width / 2
    }
    
    //TO-DO: Complete function
    func stateManager() {
        
    }
    
   // TO-DO: Define imageVector name patter and make loop to complete it, replacing textureArray
    func animate(epoch: Int) {
        if (state == stateTypes.running.rawValue) {
            for element in imageVector {
                
                if (element.key == epoch) {
                    
                    
                }
                
            }
 
        }
        
    }
    
    func setAbility() {
        ability = Ability(name: characterName)
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
