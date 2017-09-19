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
        
        for i in 1...3{
            
            var textureName = ""
            
            textureName = "sanic\(i)"
            
            texturesArray.append(SKTexture(imageNamed: textureName))
        }
        
        let texture = SKTexture(imageNamed: "sanic1")
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        setAbility()

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        let hitbox = CGSize(width: self.size.width * 0.7, height: self.size.height)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: hitbox)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player
        self.physicsBody?.collisionBitMask = PhysicsCategory.Floor

        
//        self.physicsBody?.collisionBitMask = PhysicsCategory.Obstacle | PhysicsCategory.Floor
//        self.physicsBody?.contactTestBitMask = PhysicsCategory.Obstacle
       

        
    }
    
    func jump() {
       self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))

    }
    
    func jumpAction(floorPosition: CGFloat, jumpCount: Int) {
        
        if (jumpCount <= self.maxJumps) {
        // move up 100
        let jumpUpAction = SKAction.moveTo(y: self.position.y + 120, duration: 0.4)
        // move down 100
        let jumpDownAction = SKAction.moveTo(y: floorPosition + self.size.height / 2, duration:0.5)
        // sequence of moving up then down
        let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
        
        // make player run sequence
        self.run(jumpSequence)
        self.run(AudioManager.sharedInstance.jumpSound)
            
        }
        else {
            
            return
        }
    }
    
    func startAnimation() {
        self.run(SKAction.repeatForever(SKAction.animate(with: self.texturesArray, timePerFrame: 0.2)))
        
    }
    



}
