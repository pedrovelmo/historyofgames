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
    var ability : Ability?
    var maxJumps = 2
    
    // TO-DO: Define image name pattern and update init
    init(name: String) {
        self.characterName = name
        self.state = stateTypes.running.rawValue
        let texture = SKTexture(imageNamed: name)
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        setAbility()
        
        self.physicsBody = SKPhysicsBody(texture: texture,
                                         size: texture.size())
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player
        self.physicsBody?.collisionBitMask = PhysicsCategory.Floor
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Floor
      
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //TO-DO: Complete function
    func stateManager() {
        
        
    }
    
    func setAbility() {
        ability = Ability(name: characterName)
    }
    
    func jump() {
       self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))

    }

}
