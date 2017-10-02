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
    
    static var backgroundsArray: [Background] = []
    static let maxBackgrounds = 2
    var imageName: String?
    
    init(epochId: Int) {
        
        switch epochId {
            
        case -1:
            self.imageName = "transitionBackground.png"
            
        case 0:
            self.imageName = "pongBackground.png"
        
        case 1:
            self.imageName = "pacmanBackground"
            
        case 2:
            self.imageName = "marioBackground"
        default:
            break
        }
        
        
        let texture = SKTexture(imageNamed: self.imageName!)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setBackgroundImage(epochId: Int){

            self.texture = SKTexture(imageNamed: self.imageName!)
        
    }

}
