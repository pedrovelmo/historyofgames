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
    static let transitionBackground = Background(epochId: -1)
    
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
    
    static func setTransitionBackground(scene: SKScene){
        
        transitionBackground.alpha = 0.0
        transitionBackground.size.height = scene.size.height
        transitionBackground.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        transitionBackground.zPosition = -2
        scene.addChild(transitionBackground)
        transitionBackground.run(SKAction.fadeIn(withDuration: 2))
    }
    
    static func removeTransitionBackground(scene: SKScene){
        
        transitionBackground.alpha = 1.0
        transitionBackground.run(SKAction.fadeOut(withDuration: 4.0), completion: transitionBackground.removeFromParent)
    }
    
    static func setFirstBackground(scene: SKScene){
        
        let firstBackground = Background(epochId: 0)
        
        firstBackground.size.width = (scene.size.width)
        firstBackground.size.height = (scene.size.height)
        firstBackground.position = CGPoint(x: (scene.size.width) / 2,
                                           y: (scene.size.height) / 2)
        firstBackground.zPosition = -3
        scene.addChild(firstBackground)
        Background.backgroundsArray.append(firstBackground)
    }
    
    func setBackgroundImage(epochId: Int){

            self.texture = SKTexture(imageNamed: imagesForEpochs[epochId])
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
