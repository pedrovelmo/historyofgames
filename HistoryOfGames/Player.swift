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
    
    // TO-DO: Define image name pattern and update init
    init(name: String) {
        self.characterName = name
        self.state = stateTypes.running.rawValue
        let texture = SKTexture(imageNamed: name)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        setAbility()
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
}
