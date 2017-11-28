//
//  Obstacle.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 31/08/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import UIKit
import SpriteKit


class Obstacle: SKSpriteNode {
    
   static var obstaclesArray: [Obstacle] = []
    
    private  var obstacleName: String
    private var pattern: EnemyPattern?
    private var texturesArray =  [SKTexture]()
    private var gameScene: GameScene?
    
    init(name: String, scene: GameScene) {
        
        self.obstacleName = name
        self.gameScene = scene
        
        let texture = SKTexture(imageNamed: self.obstacleName)
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        setPattern()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            
        case "pacmanBlock0":
            self.pattern = PacmanBlockPattern(obstacle: self)
            
        case "alien1-0":
            self.pattern = SpaceInvadersAlienPattern(obstacle: self)
            
        case "ghost0":
            self.pattern = PacmanGhostPattern(obstacle: self)
            
        case "tetrisTopBlockA":
            self.pattern = TetrisFallingBlockPatternTop(obstacle: self)
            
        case "tetrisBottomBlockA":
            self.pattern = TetrisFallingBlockPatternBottom(obstacle: self)
            
        case "crazyAssLink":
            self.pattern = ZeldaCrazyLinkPattern(obstacle: self)
            
        case "crazyAssLinkSword":
            self.pattern = ZeldaCrazyLinkSwordPattern(obstacle: self)
            
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
    
    func getObstacleName() -> String {
        return self.obstacleName
    }
    
    func getPattern() -> EnemyPattern {
        return self.pattern!
    }
    
    func getTexturesArray() -> [SKTexture] {
        return self.texturesArray
    }
    
    func setTexturesArray(value: [SKTexture]) {
        self.texturesArray = value
    }
    
    func appendItemInTexturesArray(value: SKTexture) {
        self.texturesArray.append(value)
    }
    
    func getGameScene() -> GameScene {
        return self.gameScene!
    }
    
 
}
