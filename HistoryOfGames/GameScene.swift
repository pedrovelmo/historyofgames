//
//  GameScene.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 31/08/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var epoch = Epoch(whatEpochIsThis: 0)
    
    var coinVector: [Coin] = []
    
    var player = Player(name: "running 2_022")
    
    var movingSpeed: CGFloat = 0
    
    var jumpCounter = 0

    var backgroundSound : BackgroundMusic = .CarminaBurana
    
    var soundPlayed: ExplosionSound = .WilhemScream
    
    var hudView: HudView?
    
    var coins: Int = 0
    
     let jumpMusic = SKAudioNode(fileNamed: "spin_jump.mp3")
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -20)
        CoinManager.sharedInstance.scene = self
        
        
        hudView = HudView(frame: self.frame)
        self.view?.addSubview(hudView!)
        
        self.movingSpeed = (self.scene?.size.width)! / 10
        
        let background = epoch.background?[0]
        background?.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background?.zPosition = -1
        self.addChild(background!)
        
        // Add first floor
        let floor = Floor(epochId: self.epoch.whatEpochIsThis!)
        // Width + 2 to compensate for the small space beetween floors.
        floor.size = CGSize(width: (self.scene?.size.width)! + 2, height: (self.scene?.size.height)! / 8)
        floor.position = CGPoint(x: (CGFloat(Floor.floorsArray.count) * (self.scene?.size.width)!), y: floor.size.height / 2)
        floor.setPhysicsBody()
        
        self.scene?.addChild(floor)
        Floor.floorsArray.append(floor)
        
        player.size = CGSize(width: 50, height: 50)
        player.position.x = (self.scene?.size.width)! / 10 + player.size.width / 2
        player.position.y = floor.size.height + player.size.height / 2
        
        self.player.setPhysicsBody()
        self.scene?.addChild(player)
        
        // Background Music configuration
        
        //AudioManager.sharedInstance.playBackgroundMusic()
        
        setCeiling()
        
        player.startAnimation()
        startSpawningObstacles()
        coinManager()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        jumpCounter = jumpCounter + 1
        
        player.jumpAction(floorPosition: Floor.floorsArray[0].size.height, jumpCount: jumpCounter)
           
        
        print("jumpCounter", jumpCounter)
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func floorManager(){
        
        for f in Floor.floorsArray{
            
            f.position.x -= speed
        }
        
        // Generates new Floors
        if(Floor.floorsArray.count <= Floor.maxFloors){
                
            let newFloor = Floor(epochId: self.epoch.whatEpochIsThis!)
            
            // Width + 2 to compensate for the small space beetween floors.
            newFloor.size = CGSize(width: (self.scene?.size.width)! + 2, height: (self.scene?.size.height)! / 8)
            newFloor.position = CGPoint(x: (CGFloat(Floor.floorsArray.count) * (self.scene?.size.width)!), y: newFloor.size.height / 2)
            
            newFloor.setPhysicsBody()
            self.scene?.addChild(newFloor)
            Floor.floorsArray.append(newFloor)
        }
        
        // Respositions floors and sets their image according to the current epoch
        if(Floor.floorsArray[0].position.x + Floor.floorsArray[0].size.width / 2 <= 0){
            
           Floor.floorsArray[0].position = CGPoint(x: (CGFloat(Floor.floorsArray.count - 1) * (self.scene?.size.width)!), y: Floor.floorsArray[0].size.height / 2)
            Floor.floorsArray[0].setFloorImage(epochId: self.epoch.whatEpochIsThis!)
            
            Floor.floorsArray.rearrange(from: 0, to: Floor.floorsArray.lastIndex)
        }
    }
    
    func startSpawningObstacles(){
        
        let wait = SKAction.wait(forDuration: 4)
        
        let spawnEnemy = SKAction.run({
            
            // TO-DO: Generate random obstacle
            
            let obstacleNumber = Int(arc4random_uniform(2))
            print("Obstacle", obstacleNumber)

            
            let newObstacle = Obstacle(name: (self.epoch.obstacles?[obstacleNumber])!)
            
            
            let randomPosition = arc4random_uniform(UInt32(UIScreen.main.bounds.height))
            
            newObstacle.position = CGPoint(x: UIScreen.main.bounds.width + 20, y: CGFloat(CGFloat(randomPosition) + Floor.floorsArray[0].size.height))
            
            self.scene?.addChild(newObstacle)
            Obstacle.obstaclesArray.append(newObstacle)
            
            
            newObstacle.pattern?.startMoving(floorPosition: Floor.floorsArray[0].size.height, sceneHeight: self.size.height)
                
 
        })
        
        let waitAndSpawnSequence = SKAction.sequence([wait, spawnEnemy])
        
        run(SKAction.repeatForever(waitAndSpawnSequence), withKey: "spawningEnemy")
    }
    
    func obstacleManager(){

        for o in Obstacle.obstaclesArray{
                        
            if(o.position.x + o.size.width / 2 <= 0){
                
                scene?.removeChildren(in: [o])
                Obstacle.obstaclesArray.remove(at: Obstacle.obstaclesArray.index(of: o)!)
            }
        }
    }
    
    func coinManager() {
        

       coinVector = CoinManager.sharedInstance.instantiateCoinPattern(pattern: 0, scene: self)
            
        for coin in coinVector {
                self.addChild(coin)
                coin.startAnimation()
            }
        }
    
    
    func setCeiling(){
        
        let sceneSize = self.scene?.size
        
        let ceiling = SKSpriteNode(color: UIColor.blue, size: CGSize(width: UIScreen.main.bounds.width, height: 1.0))
        
        ceiling.position = CGPoint(x: 0 + ceiling.size.width / 2, y: (sceneSize?.height)!)
        ceiling.physicsBody = SKPhysicsBody(rectangleOf: ceiling.size)
        ceiling.physicsBody?.isDynamic = false
        ceiling.physicsBody?.categoryBitMask = PhysicsCategory.Floor
        
        self.scene?.addChild(ceiling)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
            floorManager()
            obstacleManager()
        for coin in coinVector {
            coin.position.x -= speed
            if coin.position.x + coin.size.width / 2 <= 0 {
                coin.removeFromParent()
                
            }
        }

    }
    
    // Function to configure contact between bodies
    func didBegin(_ contact: SKPhysicsContact) {

        // If else statement checks if the bodies in touch are ball and enemy and respond accordingly
        if contact.bodyA.categoryBitMask == PhysicsCategory.Floor && contact.bodyB.categoryBitMask == PhysicsCategory.Player   {
            jumpCounter = 0
        }
            
        if contact.bodyA.categoryBitMask == PhysicsCategory.Player && contact.bodyB.categoryBitMask == PhysicsCategory.Floor   {
            jumpCounter = 0
        }
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.Obstacle && contact.bodyB.categoryBitMask == PhysicsCategory.Player {
            
            explosion((contact.bodyB.node?.position)!)
            contact.bodyB.node?.removeFromParent()
            contact.bodyA.node?.removeFromParent()
     
        }
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.Player && contact.bodyB.categoryBitMask == PhysicsCategory.Obstacle {
            
            explosion((contact.bodyA.node?.position)!)
            contact.bodyB.node?.removeFromParent()
            contact.bodyA.node?.removeFromParent()
        }
        //print("jumpCounter", jumpCounter)
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.Player && contact.bodyB.categoryBitMask == PhysicsCategory.Coin {
            
            contact.bodyB.node?.removeFromParent()
            self.coins += 50
            coinLabelUpdate()
        }
        if contact.bodyA.categoryBitMask == PhysicsCategory.Coin && contact.bodyB.categoryBitMask == PhysicsCategory.Player {
            
            contact.bodyA.node?.removeFromParent()
            self.coins += 50
            coinLabelUpdate()
            
        }
    }
    
    
    // Function to configure the explosion effect
    func explosion(_ pos: CGPoint) {
        let emitterNode = SKEmitterNode(fileNamed: "ExplosionParticles.sks")
        emitterNode?.particlePosition = pos
        emitterNode?.zPosition = 1
        
        self.addChild(emitterNode!)
        self.run(SKAction.wait(forDuration: 0.1), completion: {
            emitterNode?.removeFromParent()
        })
        
        // Configuration of the explosion sound
        
        self.run(AudioManager.sharedInstance.explosionSound)
    }
    
    // Function to update text of scoreLabel
    func coinLabelUpdate() {
      
        hudView?.coinLabel?.text = String(format: "Coin: %04u", coins)
    }
    
    
}
