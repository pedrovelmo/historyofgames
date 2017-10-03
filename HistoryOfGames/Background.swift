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
    let imagesForEpochs = ["pongBackground", "pacmanBackground", "marioBackground"]
    
    init(epochId: Int) {
        
        let texture: SKTexture
        
        if(epochId == -1){
            
            texture = SKTexture(imageNamed: "transitionBackground")
        }
        
        else{
            
            texture = SKTexture(imageNamed: imagesForEpochs[epochId])
        }
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setBackgroundImage(epochId: Int){

            self.texture = SKTexture(imageNamed: imagesForEpochs[epochId])
    }
}
