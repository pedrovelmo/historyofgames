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
    var player = Player(name: "dido")
    var movingSpeed: CGFloat = 0.0
    var jumpCounter = 0
    var hudView: HudView?
    var coins: Int = 0
    var score: Int = 0
    var timer = Timer()
    var backgroundTimer = Timer()
    var isGameOver = false
    var objectTimerIsRunning = false
    var backgroundObjectTimerIsRunning = false
    var isTransitioning = false
    var isGameModeSwipe = true
    var isInTutorial = false
    var floorPosition: CGFloat?
    var parentViewController: GameViewController?
    var numberOfDeaths = 0
    
    public override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        if (numberOfDeaths == 0) {
        self.parentViewController?.gameOverAlreadyHappened = true
       // self.parentViewController?.oldScene = self
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -20)
        CoinManager.sharedInstance.setScene(scene: self) 
      
        epoch = Epoch(whatEpochIsThis: 0, scene: self)
        
        hudView = HudView(frame: self.frame, scene: self)
        print("Instanciou outra hud view")
        self.view?.addSubview(hudView!)
        
        coinLabelUpdate()

        self.movingSpeed = (self.scene?.size.width)! / 120
        
        // Add first background
        Background.setFirstBackground(scene: self)
        
        // Add first floor
        Floor.setFirstFloor(scene: self)
        Floor.floorsArray.first?.setPhysicsBody()
        self.floorPosition = Floor.floorsArray[0].size.height
        
        // Background Music configuration
        
        AudioManager.sharedInstance.playBackgroundMusic()
        
        
        configureAndAddPlayer()
        
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
        
        
        
        if (isInTutorial) {
            createTutorial()
        }
        }
    }
    
    func configureAndAddPlayer() {
        
        player.setDefaultPlayerX(scene: self.scene!)
        player.position.x = player.getDefaultPlayerX()
        player.position.y = Floor.floorsArray[0].size.height + player.size.height / 2
        player.zPosition = 5
        self.player.setPhysicsBody()
        player.startAnimation()
        self.scene?.addChild(player)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if(location.x < self.size.width / 2){
            }
            else {
                
                tapHandler()
            }
        }
    }
    
    func tapHandler(){
        
        if (!isGameOver) {
            
            if (jumpCounter < player.getMaxJumps()) {
                jumpCounter = jumpCounter + 1
                
                player.jump(jumpCount: jumpCounter)
                self.run(AudioManager.sharedInstance.jumpSound)
                
                print("jumpCounter", jumpCounter)
            }
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
        if(!player.getToTheLeft() && !player.getToTheRight()){
            
            if(sender.direction == .right){
                if (sender.location(in: self.view).x < (self.view?.scene?.size.width)! / 2) {
                    
                    //                player.position.x += player.size.width
                    player.run(SKAction.move(to: CGPoint(x: player.position.x + player.size.width,
                                                         y: player.position.y), duration: 0.2))
                    
                    player.setToTheRight(value: true) 
                }
            }
            
            if(sender.direction == .left){
                if (sender.location(in: self.view).x < (self.view?.scene?.size.width)! / 2) {
                    
                    //                player.position.x -= player.size.width
                    player.run(SKAction.move(to: CGPoint(x: player.position.x - player.size.width,
                                                         y: player.position.y), duration: 0.1))
                    player.setToTheLeft(value: true)
                }
            }
        }
        
        if((player.getToTheRight() && sender.direction == .left) ||
            (player.getToTheLeft() && sender.direction == .right)){
            
            player.run(SKAction.move(to: CGPoint(x: player.getDefaultPlayerX(),
                                                 y: player.position.y), duration: 0.1))
            player.setToTheLeft(value: false)
            player.setToTheRight(value: false)
        }
    }
    
    func floorManager(){
        
        // Generates new Floors
        if(Floor.floorsArray.count <= Floor.maxFloors){
            
            let newFloor = Floor(epochId: self.epoch.getWhatEpochIsThis(), screenSize: self.scene!.size)
            
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
                
                let newBackground = Background(epochId: self.epoch.getWhatEpochIsThis())
                
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
                    
                    CoinManager.sharedInstance.instantiateCoinPattern(pattern: Int(randomPattern))
                }
                
                run(spawnCoin)
            }
                
            else{
                
                let spawnEnemy = SKAction.run({
                    
                    // TO-DO: Generate random obstacle
                    let numberOfObstaclesInEpoch = UInt32(CGFloat((self.epoch.getObstacles().count)))
                    let obstacleNumber = Int(arc4random_uniform(numberOfObstaclesInEpoch))
                    print("Obstacle", obstacleNumber)
                    var obstacleInEpoch = self.epoch.getObstacles()
                    
                    let newObstacle = Obstacle(name: (obstacleInEpoch[obstacleNumber]), scene: self)
                    
                    if(newObstacle.getObstacleName() == "tetrisTopBlockA"){
                        
                        let newObstacle2 = Obstacle(name: "tetrisBottomBlockA", scene: self)
                        
                        self.scene?.addChild(newObstacle)
                        self.scene?.addChild(newObstacle2)
                        Obstacle.obstaclesArray.append(newObstacle)
                        Obstacle.obstaclesArray.append(newObstacle2)
                    }
                    else{
                        
                        self.scene?.addChild(newObstacle)
                        Obstacle.obstaclesArray.append(newObstacle)
                    }
                })
                
                run(spawnEnemy)
            }
        }
    }
    
    func obstacleManager(){
        
        for o in Obstacle.obstaclesArray{
            
            o.getPattern().move()
            o.getPattern().checkPosition()
            
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
            
            isGameOver = true
            explosion((contact.bodyB.node?.position)!)
            
            for obstacle in Obstacle.obstaclesArray {
                obstacle.removeFromParent()
            }

            for pattern in CoinManager.sharedInstance.getPatternVector() {
                for coin in pattern {
                    coin.removeFromParent()
                }
                
            }
            
            if (contact.bodyA.categoryBitMask == PhysicsCategory.Player){
                contact.bodyB.node?.removeFromParent()
                contact.bodyA.node?.alpha = 0.0
            }
            
            else {
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.alpha = 0.0
            }
            
            if (isGameOver) {
            UserProfile.sharedInstance.updateUserData(coins: self.coins, score: self.score)
//            DatabaseManager.sharedInstance.updateUserData()
            hudView?.createGameOverView()
            
            }
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
            hudView?.setCoinLabel(value1: epoch.getNumberOfCoins(), value2: self.coins)
        }
    }
    
    func scoreLabelUpdate(){
        
        if(!isTransitioning){
            score += 1
            hudView?.setScoreLabel(value: score)
        }
    }
    
    func epochManager(){
        
        if((epoch.getWhatEpochIsThis() == 0 && coins >= epoch.getNumberOfCoins()) ||
            (epoch.getWhatEpochIsThis() == 1 && coins >= epoch.getNumberOfCoins()) ||
            (epoch.getWhatEpochIsThis() == 2 && coins >= epoch.getNumberOfCoins())){
            
            lastEpoch = epoch
            
            epoch = Epoch(whatEpochIsThis: -1, scene: self)
            self.movingSpeed -= 1
            
            Floor.allImages = epoch.getWhatEpochIsThis()
            
            isTransitioning = true
            
            let waitTimeBeforeTransition = SKAction.wait(forDuration: 3)
            
            let enterTransition = SKAction.run {
                for pattern in NodeManager.sharedInstance.getBackgroundNodesPatternVector() {
                    for node in pattern{
                       
                            node.removeFromParent()
                        
                    }
                }
                
                Background.setTransitionBackground(scene: self)
                
                self.createLoadingView()
            }
            
            let timeInTransition = SKAction.wait(forDuration: 5)
            
            let exitTransition = SKAction.run {
                
                self.epoch = Epoch(whatEpochIsThis: (self.lastEpoch?.getWhatEpochIsThis())! + 1, scene: self)
                
                Floor.allImages = self.epoch.getWhatEpochIsThis()
                
                for b in Background.backgroundsArray{
                    
                    b.setBackgroundImage(epochId: self.epoch.getWhatEpochIsThis())
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
        
//        if (epoch.whatEpochIsThis == 2 && coins >= epoch.numberOfCoins!) {
//            hudView?.createGameOverView()
//        }
    }
    
    func startSpawningBackgroundNodes() {
        
        if (Floor.floorsArray.count != 0) {
            backgroundObjectTimerIsRunning = false
            NodeManager.sharedInstance.createBackgroundNodes(epochId: epoch.getWhatEpochIsThis(), scene: self, floor: Floor.floorsArray[0])
        }
    }
    
    func backgroundNodeManager() {
        if (!isTransitioning) {
            for pattern in NodeManager.sharedInstance.getBackgroundNodesPatternVector() {
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
            
            let obstacleSeconds = randomBetweenNumbers(firstNum: 0.9, secondNum: 1.5)
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(obstacleSeconds), target: self, selector: (#selector(startSpawningObjects)), userInfo: nil, repeats: false)
            objectTimerIsRunning = true
        }
        
        if (!backgroundObjectTimerIsRunning && epoch.getWhatEpochIsThis() == 2) {
            
            let backgroundObjectSeconds = Double(arc4random_uniform(1)) + 0.5
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
        
    }
    
    func killAll() {
        Floor.floorsArray.removeAll()
        Background.backgroundsArray.removeAll()
        NodeManager.sharedInstance.clearAll()
        hudView?.removeFromSuperview()
        menu.killAll()
    }
}

