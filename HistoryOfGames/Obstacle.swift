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
    static var obstaclesArray: [Obstacle] = []
    
    var obstacleName: String
    var pattern: EnemyPattern?
    var state: Int
    var animationFrames: [Int : UIImage] = [ : ]
    var movementSpeed: CGFloat
     var texturesArray =  [SKTexture]()
    
    init(name: String, movementSpeed: CGFloat) {
        
        self.obstacleName = name
        self.state = animationState.standard.rawValue
        self.movementSpeed = movementSpeed
        
        let texture = SKTexture(imageNamed: self.obstacleName)
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        setPattern()
    }
    
    //TO-DO: COmplete function
    func stateManager(){
        
    }
    
    func setPattern(){
        
        switch self.obstacleName{
            
         case "pongBall":
            self.pattern = PongBallPattern(obstacle: self)
            
        case "pongBar":
            self.pattern = PongBarPattern(obstacle: self)
            
        case "turtle0":
            self.pattern = MarioTurtlePattern(obstacle: self)
            
        case "block1":
            self.pattern = MarioBlockPattern(obstacle: self)
            
        case "superblock":
            self.pattern = MarioSuperBlockPattern(obstacle: self)
            
        case "pacmanBlock":
            self.pattern = PacmanBlockPattern(obstacle: self)
            
        case "redGhost":
            self.pattern = PacmanRedGhostPattern(obstacle: self)
            
        case "blueGhost":
            self.pattern = PacmanBlueGhostPattern(obstacle: self)
            
        case "yellowGhost":
            self.pattern = PacmmanYellowGhostPattern(obstacle: self)
            
        case "greenGhost":
            self.pattern = PacManGreenGhostPattern(obstacle: self)
            
        case "greenishGhost":
            self.pattern = PacManGreenishGhostPattern(obstacle: self)
            
        default:
            break
        }
    }
    
    func configPhysicsBody(){
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
        self.physicsBody?.collisionBitMask = PhysicsCategory.Floor
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
