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
    
    var lastEpoch: Epoch?
    
    var background: Background = Background(epochId: 0)
    
    var coinVector: [Coin] = []
    
    var player = Player(name: "running 2_022")
    
    var movingSpeed: CGFloat = 0
    
    var jumpCounter = 0

    var backgroundSound : BackgroundMusic = .CarminaBurana
    
    var soundPlayed: ExplosionSound = .WilhemScream
    
    var hudView: HudView?
    
    var coins: Int = 0
    
    var score = 0
    
    var timer = Timer()
    
    var coinTimerIsRunning = false
    var obstacleTimerIsRunning = false
    var isTransitioning = false
    
    let jumpMusic = SKAudioNode(fileNamed: "spin_jump.mp3")
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -20)
        CoinManager.sharedInstance.scene = self
        
        
        hudView = HudView(frame: self.frame)
        self.view?.addSubview(hudView!)
        
        self.movingSpeed = (self.scene?.size.width)! / 200
        
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = -1
        self.addChild(background)
        
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
       
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        jumpCounter = jumpCounter + 1
        
        player.jumpAction(floorPosition: Floor.floorsArray[0].size.height, jumpCount: jumpCounter)
           
        
        print("jumpCounter", jumpCounter)
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func runTimer() {
    
    
    if (!coinTimerIsRunning) {
            let coinSeconds = Double(arc4random_uniform(5)) + 3.0
            timer = Timer.scheduledTimer(timeInterval: coinSeconds, target: self, selector: (#selector(startSpawningCoins)), userInfo: nil, repeats: false)
        coinTimerIsRunning = true
    
        }
    if (!obstacleTimerIsRunning) {
        let obstacleSeconds = Double(arc4random_uniform(4)) + 2.0
         timer = Timer.scheduledTimer(timeInterval: obstacleSeconds, target: self, selector: (#selector(startSpawningObstacles)), userInfo: nil, repeats: false)
        obstacleTimerIsRunning = true
        }
    }
    
    func floorManager(){
        
        for f in Floor.floorsArray{
            
            f.position.x -= movingSpeed
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
        
        if(!isTransitioning){
            // Comment to generate awesome trippy effect
            obstacleTimerIsRunning = false
            
            print("Entered obstacle")
       
            let spawnEnemy = SKAction.run({
            
            // TO-DO: Generate random obstacle
            let numberOfObstaclesInEpoch = UInt32(CGFloat((self.epoch.obstacles?.count)!))
            let obstacleNumber = Int(arc4random_uniform(numberOfObstaclesInEpoch))
            print("Obstacle", obstacleNumber)

            let newObstacle = Obstacle(name: (self.epoch.obstacles?[obstacleNumber])!, movementSpeed: self.movingSpeed)
    
            self.scene?.addChild(newObstacle)
            Obstacle.obstaclesArray.append(newObstacle)
            
            newObstacle.pattern?.startMoving(floorPosition: Floor.floorsArray[0].size.height, scene: self.scene!)
            })

            run(spawnEnemy)
        }
    }
    
    func obstacleManager(){

        for o in Obstacle.obstaclesArray{
            
            if(o.obstacleName == "pongBar" || o.obstacleName == "pacmanBlock" || o.obstacleName == "pacmanBlock1" || o.obstacleName == "superBlock"){
                
                o.position.x -= self.movingSpeed
            }
            
            if (o.obstacleName == "redGhost" || o.obstacleName == "blueGhost" || o.obstacleName == "greenGhost" || o.obstacleName == "greenishGhost" || o.obstacleName == "yellowGhost"  ) {
                
                o.position.x -= self.movingSpeed * 1.5
            }
            
            if(o.position.x + o.size.width / 2 <= 0){
                
                scene?.removeChildren(in: [o])
                Obstacle.obstaclesArray.remove(at: Obstacle.obstaclesArray.index(of: o)!)
            }
        }
    }
    
    func startSpawningCoins() {
        
        if(!isTransitioning){
            
            coinTimerIsRunning = false
            
            let spawnCoin = SKAction.run{
                
                let randomPattern = arc4random_uniform(2)
                
                CoinManager.sharedInstance.instantiateCoinPattern(pattern: Int(randomPattern), scene: self)
                
            }
            run(spawnCoin)
        }
 }
    
    func coinManager(){
        
        for pattern in CoinManager.sharedInstance.patternVector {
            for coin in pattern{
                coin.position.x -= movingSpeed
                if coin.position.x + coin.size.width / 2 <= 0 {
                    coin.removeFromParent()
                }
            }
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
        if(!isTransitioning){
        hudView?.coinLabel?.text = String(format: "Coin: %04u / \(epoch.numberOfCoins!)", coins)
        }
        
        else if (isTransitioning) {
            hudView?.coinLabel?.text = String(format: "Coin: %04u / \((self.lastEpoch?.numberOfCoins!)!)", coins)
        }
    }
    
    func scoreLabelUpdate(){
        
        if(!isTransitioning){
            
            score += 1
            
            hudView?.scoreLabel?.text = String(format: "Score: %08u", score)
        }
    }
    
    func epochManager(){
        
        // Switch case ou if?
        
//        switch epoch.whatEpochIsThis{
//
//        case 0?:
//            if(coins >= 500){
//                epoch = Epoch(whatEpochIsThis: epoch.whatEpochIsThis! + 1)
//            }
//
//        case 1?:
//            if(coins >= 1000){
//                epoch = Epoch(whatEpochIsThis: epoch.whatEpochIsThis! + 1)
//            }
//
//        default:
//            break
//        }
        
        if((epoch.whatEpochIsThis == 0 && coins >= 1000) ||
            epoch.whatEpochIsThis == 1 && coins >= 4000){
            
            lastEpoch = epoch
            
            epoch = Epoch(whatEpochIsThis: -1)
            
            isTransitioning = true
            
            let waitTimeBeforeTransition = SKAction.wait(forDuration: 5)
            
            let enterTransition = SKAction.run {
                
                self.background.removeFromParent()
                self.background = Background(epochId: self.epoch.whatEpochIsThis!)
                self.background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
                self.background.zPosition = -1
                self.addChild(self.background)
            }
            let timeInTransition = SKAction.wait(forDuration: 10)
            
            let exitTransition = SKAction.run {
                
                self.epoch = Epoch(whatEpochIsThis: (self.lastEpoch?.whatEpochIsThis!)! + 1)
                self.isTransitioning = false
                
                self.background.removeFromParent()
                self.background = Background(epochId: self.epoch.whatEpochIsThis!)
                self.background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
                self.background.zPosition = -1
                self.addChild(self.background)
                
            }
            
            let timeBeforeResumeSpawning = SKAction.wait(forDuration: 3)
            
            let resumeSpawning = SKAction.run {
                
                self.startSpawningObstacles()
                self.startSpawningCoins()
            }
            
            let executeTransition = SKAction.sequence([waitTimeBeforeTransition, enterTransition, timeInTransition, exitTransition, timeBeforeResumeSpawning, resumeSpawning])
            
            self.run(executeTransition)
            
            // How to improve this, make transition smoother.
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        floorManager()
        obstacleManager()
        runTimer()
        coinManager()
        scoreLabelUpdate()
        epochManager()
    }
}
