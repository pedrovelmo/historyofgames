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
        case 1:
            imageName = "photo.jpg"
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
