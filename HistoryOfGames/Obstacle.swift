//
//  Obstacle.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 31/08/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import UIKit
import SpriteKit

enum animationState: Int{
    
    case standard = 0
}

class Obstacle: SKSpriteNode {
    
    // MUDAR NA MODELAGEM O NAME
    var obstacleName: String
    var pattern: Pattern?
    var state: Int
    var animationFrames: [Int : UIImage] = [ : ]
    
    init(name: String) {
        
        self.obstacleName = name
        self.state = animationState.standard.rawValue
        
        let texture = SKTexture(imageNamed: self.obstacleName)
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        setPattern()
    }
    
    //TO-DO: COmplete function
    func stateManager(){
        
        
    }
    
    func setPattern(){
        
        self.pattern = Pattern(name: self.obstacleName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
