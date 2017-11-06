//
//  Pattern.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 04/09/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit

class EnemyPattern{
    
    var obstacle: Obstacle
    
    init(obstacle: Obstacle) {
        
        self.obstacle = obstacle
    }
    
    func startMoving(floorPosition: CGFloat, scene: SKScene){
        
//        switch self.name{

//        case "block2":
//
//            obstacle.size = CGSize(width: 40, height: 40)
//
//            obstacle.position.y = CGFloat(arc4random_uniform(UInt32(scene.size.height - obstacle.size.height / 2))) + floorPosition + obstacle.size.height / 2
//
//            obstacle.position.x = scene.size.width + 20
//
//            let randomMoveUp = Double(arc4random_uniform(UInt32(0.5))) + 0.5
//            let randomMoveDown = Double(arc4random_uniform(UInt32(0.5))) + 0.5
//            let randomMoveSideways = Double(arc4random_uniform(UInt32(0.5))) + 0.7
//
//            let moveUpAction = SKAction.moveTo(y: scene.size.height - obstacle.size.height / 2, duration: randomMoveUp)
//            // move down 100
//            let moveDownAction = SKAction.moveTo(y: floorPosition + obstacle.size.height / 2, duration: randomMoveDown)
//
//            let moveSidewaysAction = SKAction.moveBy(x: -40, y: 0, duration: randomMoveSideways)
//            // sequence of moving up then down
//            var jumpSequence: SKAction!
//
//            jumpSequence = SKAction.sequence([moveDownAction, moveSidewaysAction, moveUpAction, moveSidewaysAction])
//
//            setObstaclePhysicsBody(obstacle: obstacle)
//
//
//
//            obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
//
//        case "block3":
//
//            obstacle.size = CGSize(width: 40, height: 40)
//
//            obstacle.position.y = CGFloat(arc4random_uniform(UInt32(scene.size.height - obstacle.size.height / 2))) + floorPosition + obstacle.size.height / 2
//
//            obstacle.position.x = scene.size.width + 20
//
//            let randomMoveUp = Double(arc4random_uniform(UInt32(0.5))) + 0.5
//            let randomMoveDown = Double(arc4random_uniform(UInt32(0.5))) + 0.5
//            let randomMoveSideways = Double(arc4random_uniform(UInt32(0.5))) + 0.7
//
//            let moveUpAction = SKAction.moveTo(y: scene.size.height - obstacle.size.height / 2, duration: randomMoveUp)
//            // move down 100
//            let moveDownAction = SKAction.moveTo(y: floorPosition + obstacle.size.height / 2, duration: randomMoveDown)
//
//            let moveSidewaysAction = SKAction.moveBy(x: -40, y: 0, duration: randomMoveSideways)
//            // sequence of moving up then down
//            var jumpSequence: SKAction!
//
//            jumpSequence = SKAction.sequence([moveUpAction, moveSidewaysAction, moveDownAction, moveSidewaysAction])
//
//            setObstaclePhysicsBody(obstacle: obstacle)
//
//
//
//            obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))
//
//        case "block4":
//            obstacle.size = CGSize(width: 40, height: 40)
//
//            obstacle.position.y = CGFloat(arc4random_uniform(UInt32(scene.size.height - obstacle.size.height / 2))) + floorPosition + obstacle.size.height / 2
//
//            obstacle.position.x = scene.size.width + 20
//
//            let randomMoveUp = Double(arc4random_uniform(UInt32(0.5))) + 0.5
//            let randomMoveDown = Double(arc4random_uniform(UInt32(0.5))) + 0.5
//            let randomMoveSideways = Double(arc4random_uniform(UInt32(0.5))) + 0.7
//
//            let moveUpAction = SKAction.moveTo(y: scene.size.height - obstacle.size.height / 2, duration: randomMoveUp)
//            // move down 100
//            let moveDownAction = SKAction.moveTo(y: floorPosition + obstacle.size.height / 2, duration: randomMoveDown)
//
//            let moveSidewaysAction = SKAction.moveBy(x: -40, y: 0, duration: randomMoveSideways)
//            // sequence of moving up then down
//            var jumpSequence: SKAction!
//
//            jumpSequence = SKAction.sequence([moveUpAction, moveSidewaysAction, moveDownAction, moveSidewaysAction])
//
//            setObstaclePhysicsBody(obstacle: obstacle)
//            obstacle.run(SKAction.repeatForever(SKAction.sequence([jumpSequence])))

        
//        case "superblock1":
//
//        case "superblock2":
//            obstacle.size = CGSize(width: 70, height: 50)
//
//            obstacle.position.y = CGFloat(arc4random_uniform(UInt32(scene.size.height - obstacle.size.height / 2))) + floorPosition + obstacle.size.height / 2
//
//            obstacle.position.x = scene.size.width + 50
//
//            setObstaclePhysicsBody(obstacle: obstacle)
//
//        case "superblock3":
//            obstacle.size = CGSize(width: 120, height: 50)
//
//            obstacle.position.y = CGFloat(arc4random_uniform(UInt32(scene.size.height - obstacle.size.height / 2))) + floorPosition + obstacle.size.height / 2
//
//            obstacle.position.x = scene.size.width + 70
//
//            setObstaclePhysicsBody(obstacle: obstacle)
//

//        case "pacmanBlock1":
//
//            let width = Int(arc4random_uniform(30)) + 50
//            let height = Int(arc4random_uniform(10)) + 40
//            obstacle.size = CGSize(width: width, height: height)
//
//            obstacle.position.y = CGFloat(arc4random_uniform(UInt32(scene.size.height - obstacle.size.height / 2))) + floorPosition + obstacle.size.height / 2
//
//            obstacle.position.x = scene.size.width + 20
//
//            setObstaclePhysicsBody(obstacle: obstacle)
//
//
//

//            default:
//                break
//        }
    }
    
    func move(){
        
        
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
