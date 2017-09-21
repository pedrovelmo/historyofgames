//
//  Background.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 31/08/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import UIKit
import SpriteKit

class Background: SKSpriteNode {
    
    init(epochId: Int) {
        
        var imageName: String?
        
        switch epochId {
        case 0:
            imageName = "pongBackground.png"
        
        case 1:
            imageName = "pongBackground.png"
            
        case 2:
            imageName = "marioBackground"
        default:
            break
        }
        
        
        let texture = SKTexture(imageNamed: imageName!)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
