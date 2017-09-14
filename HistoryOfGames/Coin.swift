//
//  Coin.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 12/09/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import Foundation
import SpriteKit

class Coin: SKSpriteNode{
    
    init() {
        
        
        let texture = SKTexture(imageNamed: "coin.png")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
