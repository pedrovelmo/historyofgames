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
    
    var epoch: Epoch!
    
    var lastEpoch: Epoch?
    
    var coinVector: [Coin] = []
    
    var player = Player(name: "dido")
    
    var movingSpeed: CGFloat = 0
    
    var jumpCounter = 0

    var backgroundSound : BackgroundMusic = .CarminaBurana

    var soundPlayed: ExplosionSound = .WilhemScream
    
    var hudView: HudView?
    
    var coins: Int = 0
    
    var score = 0
    
    var timer = Timer()
    var backgroundTimer = Timer()
    
    var objectTimerIsRunning = false
    var backgroundObjectTimerIsRunning = false
    var isTransitioning = false
    
    let jumpMusic = SKAudioNode(fileNamed: "spin_jump.mp3")
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -20)
        CoinManager.sharedInstance.scene = self
        
        epoch = Epoch(whatEpochIsThis: 0, scene: self)
        
        hudView = HudView(frame: self.frame)
        self.view?.addSubview(hudView!)
        
        self.movingSpeed = (self.scene?.size.width)! / 200
        
        // Add first background
        Background.setFirstBackground(scene: self)
        
        // Add first floor
        Floor.setFirstFloor(scene: self)
        Floor.floorsArray.first?.setPhysicsBody()
        
//        player.size = CGSize(width: 50, height: 50)
        player.position.x = (self.scene?.size.width)! / 10 + player.size.width / 2
        player.position.y = Floor.floorsArray[0].size.height + player.size.height / 2
        
        self.player.setPhysicsBody()
        self.scene?.addChild(player)
        
        // Background Music configuration
        
        //AudioManager.sharedInstance.playBackgroundMusic()
        
        setCeiling()
        
        player.startAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        jumpCounter = jumpCounter + 1
        
        //player.jumpAction(floorPosition: Floor.floorsArray[0].size.height, jumpCount: jumpCounter)
        
        player.jump(jumpCount: jumpCounter)
        
        print("jumpCounter", jumpCounter)
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    func floorManager(){
        
        // Generates new Floors
        if(Floor.floorsArray.count <= Floor.maxFloors){
                
            let newFloor = Floor(epochId: self.epoch.whatEpochIsThis!, screenSize: self.scene!.size)
            
            // Width + 2 to compensate for the small space beetween floors.
            newFloor.size = CGSize(width: (self.scene?.size.width)! , height: (self.scene?.size.height)! / 8)
            newFloor.position = CGPoint(x: (CGFloat(Floor.floorsArray.count) * (self.scene?.size.width)!) , y: newFloor.size.height / 2)
            
            
            newFloor.setPhysicsBody()
            self.scene?.addChild(newFloor)
            Floor.floorsArray.append(newFloor)
        }
        
        Floor.positionX -= movingSpeed
//        for f in Floor.floorsArray{
//
//            f.position.x -= movingSpeed
//        }
//
//        // Respositions floors and sets their image according to the current epoch
//        print(Floor.floorsArray[0].position.x)
//        if Floor.isOutOfScene {
//        if(Floor.floorsArray[0].position.x + Floor.floorsArray[0].size.width / 2 <= 0){
//
//            Floor.floorsArray[0].position.x = CGFloat(Floor.floorsArray.count) * (self.scene?.size.width)! - Floor.floorsArray[0].size.width / 2
//            Floor.floorsArray[0].setFloorImage(epochId: self.epoch.whatEpochIsThis!)
//
//            Floor.floorsArray.rearrange(from: 0, to: Floor.floorsArray.lastIndex)
//        }
//    }
    }
    
    func backgroundManager(){
        
        if (!isTransitioning) {
        
        
            // Generates new Backgrounds
            if(Background.backgroundsArray.count <= Background.maxBackgrounds){
            
                let newBackground = Background(epochId: self.epoch.whatEpochIsThis!)
            
                newBackground.size.width = (self.scene?.size.width)!
                newBackground.size.height = (self.scene?.size.height)!
                newBackground.position = CGPoint(x: (CGFloat(Background.backgroundsArray.count) * (self.scene?.size.width)!), y: (self.scene?.size.height)! / 2)
            
                newBackground.zPosition = -3
            
                self.scene?.addChild(newBackground)
                Background.backgroundsArray.append(newBackground)
            }
            
            
            for b in Background.backgroundsArray {
                
                b.position.x -= movingSpeed * 0.3
            }
        
            // Respositions backgrounds and sets their image according to the current epoch
            if(Background.backgroundsArray[0].position.x + Background.backgroundsArray[0].size.width / 2 <= 0){
            
                Background.backgroundsArray[0].position = CGPoint(x: CGFloat(Background.backgroundsArray.count - 1) * (self.scene?.size.width)!, y: Background.backgroundsArray[0].size.height / 2)
            
                Background.backgroundsArray.rearrange(from: 0, to: Background.backgroundsArray.lastIndex)
            }
        }
    }
    
    func startSpawningObjects(){
        
        if(!isTransitioning){
            // Comment to generate awesome trippy effect
            objectTimerIsRunning = false
            
            let whichObjectToSpawn = arc4random_uniform(2)
            
            if(whichObjectToSpawn == 0){
                
                let spawnCoin = SKAction.run{
                    
                    let randomPattern = arc4random_uniform(2)
                    
                    CoinManager.sharedInstance.instantiateCoinPattern(pattern: Int(randomPattern), scene: self)
                }
                
                run(spawnCoin)
            }
                
            else{
                
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
    }
    
    func obstacleManager(){

        for o in Obstacle.obstaclesArray{
            
            if(o.obstacleName == "pongBar" || o.obstacleName == "pacmanBlock" || o.obstacleName == "pacmanBlock1" || o.obstacleName == "block1" || o.obstacleName == "block2" || o.obstacleName == "block3" || o.obstacleName == "block4"){
                
                o.position.x -= self.movingSpeed
            }
            
            if (o.obstacleName == "redGhost" || o.obstacleName == "blueGhost" || o.obstacleName == "greenGhost" || o.obstacleName == "greenishGhost" || o.obstacleName == "yellowGhost"  ) {
                
                o.position.x -= self.movingSpeed * 1.5
            }
            
            if(o.obstacleName == "turtle"){
                
                o.position.x -= 2 * self.movingSpeed
            }
            
            if(o.position.x + o.size.width / 2 <= 0){
                
                scene?.removeChildren(in: [o])
                Obstacle.obstaclesArray.remove(at: Obstacle.obstaclesArray.index(of: o)!)
            }
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
        
        let emitterNode = SKEmitterNode(fileNamed: "MyParticle.sks")
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
        
        if((epoch.whatEpochIsThis == 0 && coins >= 1000) ||
            epoch.whatEpochIsThis == 1 && coins >= 4000){
            
            lastEpoch = epoch
            
            epoch = Epoch(whatEpochIsThis: -1, scene: self)
            
            Floor.allImages = epoch.whatEpochIsThis!
            
            isTransitioning = true
            
            let waitTimeBeforeTransition = SKAction.wait(forDuration: 5)
            
            let enterTransition = SKAction.run {
                
                Background.setTransitionBackground(scene: self)
            }
            
            let timeInTransition = SKAction.wait(forDuration: 10)
            
            let exitTransition = SKAction.run {
                
                self.epoch = Epoch(whatEpochIsThis: (self.lastEpoch?.whatEpochIsThis!)! + 1, scene: self)
                
                Floor.allImages = self.epoch.whatEpochIsThis!
                
                for b in Background.backgroundsArray{
                    
                    b.setBackgroundImage(epochId: self.epoch.whatEpochIsThis!)
                }
                
                // Fade out transition background
                
                Background.removeTransitionBackground(scene: self)
            }
            
            let timeBeforeResumeSpawning = SKAction.wait(forDuration: 3)
            
            let resumeSpawning = SKAction.run {
                self.isTransitioning = false
                self.startSpawningObjects()
            }
            
            let executeTransition = SKAction.sequence([waitTimeBeforeTransition, enterTransition, timeInTransition, exitTransition, timeBeforeResumeSpawning, resumeSpawning])
            
            self.run(executeTransition)
        }
    }
    
    func startSpawningBackgroundNodes() {
        backgroundObjectTimerIsRunning = false
        NodeManager.sharedInstance.createBackgroundNodes(epochId: epoch.whatEpochIsThis!, scene: self, floor: Floor.floorsArray[0])
        print("Spawning Background Nodes")
        
    }
    
    func backgroundNodeManager() {
        if (!isTransitioning) {
            
            for pattern in NodeManager.sharedInstance.backgroundNodesPatternVector {
                for node in pattern{
                    node.position.x -= movingSpeed
                    if node.position.x + node.size.width / 2 <= 0 {
                        node.removeFromParent()
                    }
                }
            }
        }
        
    }
    
    func runTimer() {
        
        if (!objectTimerIsRunning) {
            
            let obstacleSeconds = Double(arc4random_uniform(4)) + 2.0
            timer = Timer.scheduledTimer(timeInterval: obstacleSeconds, target: self, selector: (#selector(startSpawningObjects)), userInfo: nil, repeats: false)
            objectTimerIsRunning = true
        }
        
        if (!backgroundObjectTimerIsRunning) {
            
            let backgroundObjectSeconds = Double(arc4random_uniform(2)) + 0.5
            backgroundTimer = Timer.scheduledTimer(timeInterval: backgroundObjectSeconds, target: self, selector: (#selector(startSpawningBackgroundNodes)), userInfo: nil, repeats: false)
            backgroundObjectTimerIsRunning = true
        }
    }
    
    func updateFloorSpeed() {
        
        if (!isTransitioning) {
        self.movingSpeed = 0.0007 + self.movingSpeed
        
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        floorManager()
        obstacleManager()
        runTimer()
        coinManager()
        scoreLabelUpdate()
        epochManager()
        backgroundManager()
        backgroundNodeManager()
        updateFloorSpeed()
    }
}
