//
//  HudView.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 19/09/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import UIKit
import SpriteKit

class HudView: UIView {
    
    var coinLabel : UILabel?
    var scoreLabel: UILabel?

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        setupHud()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHud() {

        let labelSize =  CGSize(width: self.frame.width * 0.1, height: self.frame.height * 0.05)
        self.coinLabel = UILabel()
        self.scoreLabel = UILabel()
       // coinLabel?.text = String(format: "Coin: %04u / 1000", 0000)
        coinLabel?.font = UIFont(name: "chalkduster", size: 15)
        coinLabel?.alpha = 1.0
        coinLabel?.textColor = UIColor.red
        coinLabel?.frame = CGRect(x: self.frame.size.width - labelSize.width * 3.3, y: self.frame.size.height * 0.05 , width: labelSize.width * 3.0, height: labelSize.height)
        
        //scoreLabel?.text = String(format: "Score: %08u", 0000)
        scoreLabel?.font = UIFont(name: "chalkduster", size: 15)
        scoreLabel?.alpha = 1.0
        scoreLabel?.textColor = UIColor.white
        scoreLabel?.frame = CGRect(x: labelSize.width * 0.5, y: self.frame.size.height * 0.05 , width: labelSize.width * 4, height: labelSize.height)

        self.addSubview(coinLabel!)
        self.addSubview(scoreLabel!)
    }
    
    func createGameOverView(scene: GameScene){
        
        scene.isGameOver = true
        scene.coins = 0
        scene.score = 0
        
        let gameOverView = SKSpriteNode(imageNamed: "gameOver.png")
        gameOverView.position = CGPoint(x: (self.frame.size.width)/2, y: (self.frame.size.height)/2)
        gameOverView.zPosition = 10
        gameOverView.size = CGSize(width: (self.frame.size.width / 1.2), height: (self.frame.size.height / 1.1))
        gameOverView.alpha = 1.0
        scene.addChild(gameOverView)
    }
}
