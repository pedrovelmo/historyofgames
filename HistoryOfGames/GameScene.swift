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
    
    var menu: MenuViewController!
    var epoch: Epoch!
    var lastEpoch: Epoch?
    var coinVector: [Coin] = []
    var player = Player(name: "dido")
    var movingSpeed: CGFloat = 0.0
    var jumpCounter = 0
    var hudView: HudView?
    var gameOverView: SKSpriteNode?
    var coins: Int = 0
    var score = 0
    var timer = Timer()
    var backgroundTimer = Timer()
    var isGameOver = false
    var objectTimerIsRunning = false
    var backgroundObjectTimerIsRunning = false
    var isTransitioning = false
    var isGameModeSwipe = true
    var isInTutorial = false
    var gameMode: String!
    var floorPosition: CGFloat?
    
    public init(size: CGSize, gameMode: String) {
        super.init(size: size)
        self.gameMode = gameMode
        print("Init")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -20)
        CoinManager.sharedInstance.scene = self
        isGameOver = false
        
        epoch = Epoch(whatEpochIsThis: 1, scene: self, gameMode: gameMode)
        
        hudView = HudView(frame: self.frame)
        self.view?.addSubview(hudView!)
        
        coinLabelUpdate()
        print("gameMode", gameMode)
        
        switch(gameMode) {
            
        case "easy":
            self.movingSpeed = (self.scene?.size.width)! / 180
        case "medium":
            self.movingSpeed = (self.scene?.size.width)! / 150
        case "hard":
            self.movingSpeed = (self.scene?.size.width)! / 100
        default: break
        }
        
        // Add first background
        Background.setFirstBackground(scene: self)
        
        // Add first floor
        Floor.setFirstFloor(scene: self)
        Floor.floorsArray.first?.setPhysicsBody()
        self.floorPosition = Floor.floorsArray[0].size.height
        
        player.setDefaultX(scene: self.scene!)
        player.position.x = player.defaultPlayerX
        player.position.y = Floor.floorsArray[0].size.height + player.size.height / 2
        
        self.player.setPhysicsBody()
        self.scene?.addChild(player)
        
        // Background Music configuration
        
        AudioManager.sharedInstance.playBackgroundMusic()
        
        
        
        if (isGameModeSwipe) {
            let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeHandler(sender:)))
            swipeRightRecognizer.direction = UISwipeGestureRecognizerDirection.right
            
            let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeHandler(sender:)))
            swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirection.left
            
            self.view?.addGestureRecognizer(swipeRightRecognizer)
            self.view?.addGestureRecognizer(swipeLeftRecognizer)
        }
            
        else {
            let panRecognizer = UIPanGestureRecognizer(target: self, action : #selector(self.panHandler(sender: )))
            self.view?.addGestureRecognizer(panRecognizer)
            
        }
        setCeiling()
        
        player.startAnimation()
        
        if (isInTutorial) {
            createTutorial()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if(location.x < self.size.width / 2){
                print("Left, no jump executed")
            }
            else {
                print("Right, jump")
                tapHandler()
                
            }
        }
    }
    
    func tapHandler(){
        
        if (!isGameOver) {
            
            if (jumpCounter < player.maxJumps) {
                jumpCounter = jumpCounter + 1
                
                player.jump(jumpCount: jumpCounter)
                self.run(AudioManager.sharedInstance.jumpSound)
                
                print("jumpCounter", jumpCounter)
            }
        }
            
        else {
            Floor.floorsArray.removeAll()
            Background.backgroundsArray.removeAll()
            NodeManager.sharedInstance.clearAll()
            menu.killAll()
        }
    }
    
    func panHandler(sender: UIPanGestureRecognizer){
        
        let translation = sender.translation(in: self.view)
        
        player.position = CGPoint(x:player.position.x + translation.x,
                                  y:player.position.y + translation.y)
        
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func swipeHandler(sender: UISwipeGestureRecognizer){
        
        // Player is in default position
        if(!player.toTheLeft && !player.toTheRight){
            
            if(sender.direction == .right){
                if (sender.location(in: self.view).x < (self.view?.scene?.size.width)! / 2) {
                    
                    //                player.position.x += player.size.width
                    player.run(SKAction.move(to: CGPoint(x: player.position.x + player.size.width,
                                                         y: player.position.y), duration: 0.2))
                    
                    player.toTheRight = true
                }
            }
            
            if(sender.direction == .left){
                if (sender.location(in: self.view).x < (self.view?.scene?.size.width)! / 2) {
                    
                    //                player.position.x -= player.size.width
                    player.run(SKAction.move(to: CGPoint(x: player.position.x - player.size.width,
                                                         y: player.position.y), duration: 0.1))
                    player.toTheLeft = true
                }
            }
        }
        
        if((player.toTheRight && sender.direction == .left) ||
            (player.toTheLeft && sender.direction == .right)){
            
            player.run(SKAction.move(to: CGPoint(x: player.defaultPlayerX,
                                                 y: player.position.y), duration: 0.1))
            player.toTheRight = false
            player.toTheLeft = false
        }
    }
    
    func floorManager(){
        
        // Generates new Floors
        if(Floor.floorsArray.count <= Floor.maxFloors){
            
            let newFloor = Floor(epochId: self.epoch.whatEpochIsThis!, screenSize: self.scene!.size)
            
            newFloor.size = CGSize(width: (self.scene?.size.width)! , height: (self.scene?.size.height)! / 8)
            newFloor.position = CGPoint(x: (CGFloat(Floor.floorsArray.count) * (self.scene?.size.width)!) , y: newFloor.size.height / 2)
            
            newFloor.setPhysicsBody()
            self.scene?.addChild(newFloor)
            Floor.floorsArray.append(newFloor)
        }
        
        Floor.positionX -= movingSpeed
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
            
            Background.positionX -= movingSpeed * 0.3
        }
    }
    
    func startSpawningObjects(){
        
        if(!isTransitioning){
            // Comment to generate awesome trippy effect
            objectTimerIsRunning = false
            
            let whichObjectToSpawn = arc4random_uniform(5)
            
            if(whichObjectToSpawn == 2){
                
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
                    
                    let newObstacle = Obstacle(name: (self.epoch.obstacles?[obstacleNumber])!, scene: self)
                    
                    self.scene?.addChild(newObstacle)
                    Obstacle.obstaclesArray.append(newObstacle)
                })
                
                run(spawnEnemy)
            }
        }
    }
    
    func obstacleManager(){
        
        for o in Obstacle.obstaclesArray{
            
            o.pattern?.move()
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
        if (contact.bodyA.categoryBitMask == PhysicsCategory.Floor && contact.bodyB.categoryBitMask == PhysicsCategory.Player)
        || (contact.bodyA.categoryBitMask == PhysicsCategory.Player && contact.bodyB.categoryBitMask == PhysicsCategory.Floor) {
            jumpCounter = 0
        }
        
        if (contact.bodyA.categoryBitMask == PhysicsCategory.Obstacle && contact.bodyB.categoryBitMask == PhysicsCategory.Player)
        || (contact.bodyA.categoryBitMask == PhysicsCategory.Player && contact.bodyB.categoryBitMask == PhysicsCategory.Obstacle){
            
            explosion((contact.bodyB.node?.position)!)
            contact.bodyB.node?.removeFromParent()
            contact.bodyA.node?.removeFromParent()
            UserProfile.sharedInstance.updateUserData(coins: self.coins, highScore: self.score)
            DatabaseManager.sharedInstance.updateUserData()
            hudView?.createGameOverView(scene: self)
        }
        
        if (contact.bodyA.categoryBitMask == PhysicsCategory.Player && contact.bodyB.categoryBitMask == PhysicsCategory.Coin)
        || (contact.bodyA.categoryBitMask == PhysicsCategory.Coin && contact.bodyB.categoryBitMask == PhysicsCategory.Player){
            
            contact.bodyB.node?.removeFromParent()
            self.coins += 25
            coinLabelUpdate()
            self.run(AudioManager.sharedInstance.coinSound)
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
        
        if (!isTransitioning) {
            hudView?.coinLabel?.text = String(format: "Coin: %04u / \(epoch.numberOfCoins!)", self.coins)
        }
    }
    
    func scoreLabelUpdate(){
        
        if(!isTransitioning){
            score += 1
            hudView?.scoreLabel?.text = String(format: "Score: %08u", score)
        }
    }
    
    func epochManager(){
        
        if((epoch.whatEpochIsThis! == 0 && coins >= epoch.numberOfCoins!) ||
            epoch.whatEpochIsThis! == 1 && coins >= epoch.numberOfCoins!){
            
            lastEpoch = epoch
            
            epoch = Epoch(whatEpochIsThis: -1, scene: self, gameMode: gameMode)
            
            // Can this be delayed?
            Floor.allImages = epoch.whatEpochIsThis!
            
            isTransitioning = true
            
            let waitTimeBeforeTransition = SKAction.wait(forDuration: 3)
            
            let enterTransition = SKAction.run {
                
                Background.setTransitionBackground(scene: self)
                
                self.createLoadingView()
                
            }
            
            let timeInTransition = SKAction.wait(forDuration: 5)
            
            let exitTransition = SKAction.run {
                
                self.epoch = Epoch(whatEpochIsThis: (self.lastEpoch?.whatEpochIsThis!)! + 1, scene: self, gameMode: self.gameMode)
                
                Floor.allImages = self.epoch.whatEpochIsThis!
                
                for b in Background.backgroundsArray{
                    
                    b.setBackgroundImage(epochId: self.epoch.whatEpochIsThis!)
                }
                
                // Fade out transition background
                
                Background.removeTransitionBackground(scene: self)
            }
            
            let timeBeforeResumeSpawning = SKAction.wait(forDuration: 2.5)
            
            let resumeSpawning = SKAction.run {
                self.isTransitioning = false
                self.startSpawningObjects()
                self.coinLabelUpdate()
            }
            
            let executeTransition = SKAction.sequence([waitTimeBeforeTransition, enterTransition, timeInTransition, exitTransition, timeBeforeResumeSpawning, resumeSpawning])
            
            self.run(executeTransition)
        }
        
        if (epoch.whatEpochIsThis == 2 && coins >= epoch.numberOfCoins!) {
            hudView?.createGameOverView(scene: self)
        }
    }
    
    func startSpawningBackgroundNodes() {
        
        print("Epoch = ", epoch.whatEpochIsThis)
        print("Count Floor", Floor.floorsArray.count)
        
        if (Floor.floorsArray.count != 0) {
            backgroundObjectTimerIsRunning = false
            NodeManager.sharedInstance.createBackgroundNodes(epochId: epoch.whatEpochIsThis!, scene: self, floor: Floor.floorsArray[0])
            print("Spawning Background Nodes")
        }
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
            
            let obstacleSeconds = randomBetweenNumbers(firstNum: 0.7, secondNum: 1.5)
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(obstacleSeconds), target: self, selector: (#selector(startSpawningObjects)), userInfo: nil, repeats: false)
            objectTimerIsRunning = true
        }
        
        if (!backgroundObjectTimerIsRunning && epoch.whatEpochIsThis == 2) {
            
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
        
        if (!isGameOver && !isInTutorial) {
            floorManager()
            obstacleManager()
            runTimer()
            CoinManager.sharedInstance.manageCoins(speed: self.movingSpeed)
            scoreLabelUpdate()
            epochManager()
            backgroundManager()
            backgroundNodeManager()
            updateFloorSpeed()
        }
    }
    
    func createLoadingView() {
        let loadingView = UIView(frame: CGRect(x: self.frame.width / 2 - 80, y: self.frame.height / 2 , width: 0, height: 40))
        
        UIView.animate(withDuration: 5.5,
                       animations: {
                        loadingView.frame.size = CGSize(width: 250, height: 40)
                        loadingView.backgroundColor = UIColor.blue
        },
                       completion: { finished in
                        if(finished) {
                            
                            let wait = SKAction.wait(forDuration: 2.0)
                            let removeView = SKAction.run {
                                loadingView.removeFromSuperview()
                            }
                            
                            self.run(SKAction.sequence([wait, removeView]))
                            
                        }
        })
        
        self.view?.addSubview(loadingView)
        
    }
    
    func createTutorial() {
        
        var hand = SKSpriteNode(imageNamed: "hand")
        hand.position = CGPoint(x: hand.size.width / 2 + player.position.x, y: hand.size.height / 2 + player.position.y)
        hand.size = CGSize(width: 50, height: 50)
        var handMoveRight = SKAction.moveTo(x: hand.size.width / 2 + player.position.x + 50, duration: 1.5)
        var handMoveLeft = SKAction.moveTo(x: hand.size.width / 2 + player.position.x - 50, duration: 1.5)
        var handMove = SKAction.sequence([handMoveRight, handMoveLeft])
        
        var handSequence = SKAction.repeatForever(SKAction.sequence([handMove]))
        self.scene?.addChild(hand)
        hand.run(SKAction.sequence([handSequence]))
        
        //        isInTutorial = false
        
    }
}

