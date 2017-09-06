//
//  Floor.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 31/08/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import UIKit
import SpriteKit

class Floor: SKSpriteNode {
    
    static var floorsArray: [Floor] = []
    static let maxFloors = 2
    static let imagesForEpochs = ["grama.jpg"]
    
    init(epochId: Int) {
        
        let texture = SKTexture(imageNamed: Floor.imagesForEpochs[epochId])
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = 1
    }
    
    func setFloorImage(epochId: Int){
        
        self.texture = SKTexture(imageNamed: Floor.imagesForEpochs[epochId])
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
