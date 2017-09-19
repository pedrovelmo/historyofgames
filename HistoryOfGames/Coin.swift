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
    
    var texturesArray =  [SKTexture]()
    
    init() {
        
        for i in 0...5{
            
            let textureName = "coin\(i)"
            texturesArray.append(SKTexture(imageNamed: textureName))
            
        }
        super.init(texture: texturesArray[0], color: UIColor.clear, size: texturesArray[0].size())

        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation() {
              self.run(SKAction.repeatForever(SKAction.animate(with: self.texturesArray, timePerFrame: 0.1)))
    }
    
    func setPhysicsBody() {
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Coin
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        self.physicsBody?.isDynamic = false
    }

}
