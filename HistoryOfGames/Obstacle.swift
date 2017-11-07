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
    var texturesArray =  [SKTexture]()
    var gameScene: GameScene?
    
    init(name: String, scene: GameScene) {
        
        self.obstacleName = name
        self.state = animationState.standard.rawValue
        self.gameScene = scene
        
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
            
//        case "superblock":
//            self.pattern = MarioSuperBlockPattern(obstacle: self)
            
        case "pacmanBlock0":
            self.pattern = PacmanBlockPattern(obstacle: self)
            
        case "ghost0":
            self.pattern = PacmanGhostPattern(obstacle: self)

            
        default:
            break
        }
    }
    
    func configPhysicsBody(){
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
        self.physicsBody?.collisionBitMask = PhysicsCategory.Floor
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.friction = 0.0
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.angularDamping = 0.0
        self.physicsBody?.linearDamping = 0.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
