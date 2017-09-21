//
//  Pattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 04/09/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class Pattern{
    
    var obstacle: Obstacle
    
    var name: String
    
    init(name: String, obstacle: Obstacle) {
        
        self.name = name
        self.obstacle = obstacle
    }
    
    func startMoving(floorPosition: CGFloat, scene: SKScene){
        
        switch self.name{
            
            case "pongBall":
                
                // TO-DO: Rearrange this size setting
                obstacle.size = CGSize(width: 10, height: 10)
                
                let randomPosition = arc4random_uniform(UInt32(scene.size.height))
                
                obstacle.position = CGPoint(x: scene.size.width + 20, y: CGFloat(CGFloat(randomPosition) + floorPosition))
                
                setObstaclePhysicsBody(obstacle: obstacle)
                
                obstacle.physicsBody?.mass = (obstacle.physicsBody?.mass)! * 8
                obstacle.physicsBody?.applyImpulse(CGVector(dx: -11, dy: -9))
            
            case "pongBar":
                obstacle.size = CGSize(width: 10, height: 50)
                
                let randomPosition = Int(arc4random_uniform(2))
                
                let moveUpAction = SKAction.moveTo(y: scene.size.height - obstacle.size.height / 2, duration: 1.5)
                // move down 100
                let moveDownAction = SKAction.moveTo(y: floorPosition + obstacle.size.height / 2, duration:1.5)
                // sequence of moving up then down
                var jumpSequence: SKAction!
                
                if(randomPosition == 0){
                    
                    obstacle.position.y = floorPosition + obstacle.size.height / 2
                     jumpSequence = SKAction.sequence([moveUpAction, moveDownAction])
                }
                else{
                    obstacle.position.y = scene.size.height - obstacle.size.height / 2
                     jumpSequence = SKAction.sequence([moveDownAction, moveUpAction])
                }
                
                obstacle.position.x = scene.size.width + 20
                setObstaclePhysicsBody(obstacle: obstacle)

                obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
            
        case "pacmanBlock":
            
            let width = Int(arc4random_uniform(40)) + 10
            let height = Int(arc4random_uniform(40)) + 10
            obstacle.size = CGSize(width: width, height: height)
                
            obstacle.position.y = CGFloat(arc4random_uniform(UInt32(scene.size.height - obstacle.size.height / 2))) + floorPosition + obstacle.size.height / 2

            obstacle.position.x = scene.size.width + 20
            
            setObstaclePhysicsBody(obstacle: obstacle)
            
        case "pacmanBlock1":
            
            let width = Int(arc4random_uniform(40)) + 10
            let height = Int(arc4random_uniform(40)) + 10
            obstacle.size = CGSize(width: width, height: height)
            
            obstacle.position.y = CGFloat(arc4random_uniform(UInt32(scene.size.height - obstacle.size.height / 2))) + floorPosition + obstacle.size.height / 2
            
            obstacle.position.x = scene.size.width + 20
            
            setObstaclePhysicsBody(obstacle: obstacle)
            
        
            
      // Start ghost Cases
        case "redGhost":
            obstacle.size = CGSize(width: 30, height: 30)
            
            let randomPosition = Int(arc4random_uniform(2))
            
            let moveUpAction = SKAction.moveTo(y: scene.size.height - obstacle.size.height / 2, duration: 1.5)
            // move down 100
            let moveDownAction = SKAction.moveTo(y: floorPosition + obstacle.size.height / 2, duration:1.5)
            
            let moveSidewaysAction = SKAction.moveTo(x: -30, duration: 1.5)
            // sequence of moving up then down
            var jumpSequence: SKAction!
            
            if(randomPosition == 0){
                
                obstacle.position.y = floorPosition + obstacle.size.height / 2
                jumpSequence = SKAction.sequence([moveUpAction, moveDownAction])
            }
            else{
                obstacle.position.y = scene.size.height - obstacle.size.height / 2
                jumpSequence = SKAction.sequence([moveDownAction, moveUpAction])
            }
            
            obstacle.position.x = scene.size.width + 20
            setObstaclePhysicsBody(obstacle: obstacle)
            
            obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
            
        case "blueGhost":
            obstacle.size = CGSize(width: 30, height: 30)
            
            let randomPosition = Int(arc4random_uniform(2))
            
            let moveUpAction = SKAction.moveTo(y: scene.size.height - obstacle.size.height / 2, duration: 1.5)
            // move down 100
            let moveDownAction = SKAction.moveTo(y: floorPosition + obstacle.size.height / 2, duration:1.5)
            
            let moveSidewaysAction = SKAction.moveTo(x: -30, duration: 1.5)
            // sequence of moving up then down
            var jumpSequence: SKAction!
            
            if(randomPosition == 0){
                
                obstacle.position.y = floorPosition + obstacle.size.height / 2
                jumpSequence = SKAction.sequence([moveUpAction, moveDownAction])
            }
            else{
                obstacle.position.y = scene.size.height - obstacle.size.height / 2
                jumpSequence = SKAction.sequence([moveDownAction, moveUpAction])
            }
            
            obstacle.position.x = scene.size.width + 20
            setObstaclePhysicsBody(obstacle: obstacle)
            
            obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
            
        case "yellowGhost":
            obstacle.size = CGSize(width: 30, height: 30)
            
            let randomPosition = Int(arc4random_uniform(2))
            
            let moveUpAction = SKAction.moveTo(y: scene.size.height - obstacle.size.height / 2, duration: 1.5)
            // move down 100
            let moveDownAction = SKAction.moveTo(y: floorPosition + obstacle.size.height / 2, duration:1.5)
            
            let moveSidewaysAction = SKAction.moveTo(x: -30, duration: 1.5)
            // sequence of moving up then down
            var jumpSequence: SKAction!
            
            if(randomPosition == 0){
                
                obstacle.position.y = floorPosition + obstacle.size.height / 2
                jumpSequence = SKAction.sequence([moveUpAction, moveDownAction])
            }
            else{
                obstacle.position.y = scene.size.height - obstacle.size.height / 2
                jumpSequence = SKAction.sequence([moveDownAction, moveUpAction])
            }
            
            obstacle.position.x = scene.size.width + 20
            setObstaclePhysicsBody(obstacle: obstacle)
            
            obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
            
        case "greenGhost":
            obstacle.size = CGSize(width: 30, height: 30)
            
            let randomPosition = Int(arc4random_uniform(2))
            
            let moveUpAction = SKAction.moveTo(y: scene.size.height - obstacle.size.height / 2, duration: 1.5)
            // move down 100
            let moveDownAction = SKAction.moveTo(y: floorPosition + obstacle.size.height / 2, duration:1.5)
            
            let moveSidewaysAction = SKAction.moveTo(x: -30, duration: 1.5)
            // sequence of moving up then down
            var jumpSequence: SKAction!
            
            if(randomPosition == 0){
                
                obstacle.position.y = floorPosition + obstacle.size.height / 2
                jumpSequence = SKAction.sequence([moveUpAction, moveDownAction])
            }
            else{
                obstacle.position.y = scene.size.height - obstacle.size.height / 2
                jumpSequence = SKAction.sequence([moveDownAction, moveUpAction])
            }
            
            obstacle.position.x = scene.size.width + 20
            setObstaclePhysicsBody(obstacle: obstacle)
            
            obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
            
        case "greenishGhost":
            obstacle.size = CGSize(width: 30, height: 30)
            
            let randomPosition = Int(arc4random_uniform(2))
            
            let moveUpAction = SKAction.moveTo(y: scene.size.height - obstacle.size.height / 2, duration: 1.5)
            // move down 100
            let moveDownAction = SKAction.moveTo(y: floorPosition + obstacle.size.height / 2, duration:1.5)
            
            let moveSidewaysAction = SKAction.moveTo(x: -30, duration: 1.5)
            // sequence of moving up then down
            var jumpSequence: SKAction!
            
            if(randomPosition == 0){
                
                obstacle.position.y = floorPosition + obstacle.size.height / 2
                jumpSequence = SKAction.sequence([moveUpAction, moveDownAction])
            }
            else{
                obstacle.position.y = scene.size.height - obstacle.size.height / 2
                jumpSequence = SKAction.sequence([moveDownAction, moveUpAction])
            }
            
            obstacle.position.x = scene.size.width + 20
            setObstaclePhysicsBody(obstacle: obstacle)
            
            obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
            default:
                break
        }
    }
    
    
    func setObstaclePhysicsBody(obstacle: Obstacle) {
        obstacle.configPhysicsBody()
        
        obstacle.physicsBody?.affectedByGravity = false
        obstacle.physicsBody?.friction = 0.0
        obstacle.physicsBody?.restitution = 1.0
        obstacle.physicsBody?.allowsRotation = false
        obstacle.physicsBody?.angularDamping = 0.0
        obstacle.physicsBody?.linearDamping = 0.0
        
    }
}
