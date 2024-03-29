//
//  HudView.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 19/09/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import UIKit
import SpriteKit



class HudView: UIView  {
  
    private var coinLabel : UILabel?
    private var scoreLabel: UILabel?
    private var scene: GameScene?
    var root: UIViewController?
    var gameOverView: UIImageView?
    var menuButton: UIButton?
    var aButton: UIButton?

     init(frame: CGRect, scene: GameScene) {
        
        super.init(frame: frame)
        self.scene = scene
        
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
        coinLabel?.font = UIFont(name: "Gameplay", size: 15)
        coinLabel?.alpha = 1.0
        coinLabel?.textColor = UIColor.red
        coinLabel?.frame = CGRect(x: self.frame.size.width - labelSize.width * 3.3, y: self.frame.size.height * 0.05 , width: labelSize.width * 3.0, height: labelSize.height)
        
        //scoreLabel?.text = String(format: "Score: %08u", 0000)
        scoreLabel?.font = UIFont(name: "Gameplay", size: 15)
        scoreLabel?.alpha = 1.0
        scoreLabel?.textColor = UIColor.white
        scoreLabel?.frame = CGRect(x: labelSize.width * 0.5, y: self.frame.size.height * 0.05 , width: labelSize.width * 4, height: labelSize.height)

        self.addSubview(coinLabel!)
        self.addSubview(scoreLabel!)
    }
    
    func createGameOverView(){
        
        scene?.isGameOver = true
        scene?.numberOfDeaths += 1
        
        gameOverView = UIImageView(frame: CGRect(
            x: (self.frame.size.width)/2,
            y: (self.frame.size.height)/2,
            width: self.frame.size.width * 0.7,
            height: self.frame.size.height * 0.6)
        )
        
        gameOverView?.image = UIImage(named: "gameOver")
        gameOverView?.frame.origin = CGPoint(
            x: (gameOverView?.frame.origin.x)! - (gameOverView?.frame.size.width)! / CGFloat(2),
            y: (gameOverView?.frame.origin.y)! - (gameOverView?.frame.size.height)! / CGFloat(2)
        )
        
        aButton = UIButton(frame: CGRect(
            x: self.frame.size.width / 2,
            y: self.frame.size.height / 2,
            width: (gameOverView?.frame.size.width)! / 4,
            height: (gameOverView?.frame.size.height)! / 5)
        )
        
        aButton?.frame.origin = CGPoint(
            x: (aButton?.frame.origin.x)! - (aButton?.frame.size.width)! / CGFloat(2),
            y: (aButton?.frame.origin.y)! - (aButton?.frame.size.height)! / CGFloat(2)
        )
        
        aButton?.setImage(UIImage(named: "playAdButton"), for: UIControlState.normal)
        aButton?.alpha = 1.0
        aButton?.addTarget(self, action: #selector(playAdAndReplay), for: UIControlEvents.touchUpInside)
        
        
        menuButton = UIButton(frame: CGRect(
            x: self.frame.size.width / 2,
            y: self.frame.size.height / 1.5,
            width: (gameOverView?.frame.size.width)! / 4,
            height: (gameOverView?.frame.size.height)! / 5)
        )
        
        menuButton?.frame.origin = CGPoint(
            x: (menuButton?.frame.origin.x)! - (menuButton?.frame.size.width)! / CGFloat(2),
            y: (menuButton?.frame.origin.y)! - (menuButton?.frame.size.height)! / CGFloat(2)
        )
        
        menuButton?.setImage(UIImage(named: "menu"), for: UIControlState.normal)
        menuButton?.alpha = 1.0
        menuButton?.addTarget(self, action: #selector(menuAction), for: UIControlEvents.touchUpInside)
        
        scene?.view?.addSubview(gameOverView!)
        scene?.view?.addSubview(aButton!)
        scene?.view?.addSubview(menuButton!)
    }
    
    // TO-DO: return to Menu
    func menuAction(sender:UIButton!) {
        // Kill Scene and return to Menu

        self.gameOverView?.removeFromSuperview()
        self.menuButton?.removeFromSuperview()
        self.aButton?.removeFromSuperview()
        self.removeFromSuperview()
        scene?.isGameOver = false
        scene?.killAll()
        scene?.parentViewController?.launchViewController(scene: scene!)
    }
    
    func goToMenu() {
        
        self.gameOverView?.removeFromSuperview()
        self.menuButton?.removeFromSuperview()
        self.aButton?.removeFromSuperview()
        self.removeFromSuperview()
        scene?.isGameOver = false
        scene?.killAll()
        scene?.parentViewController?.launchViewController(scene: scene!)
    }
    
    func playAdAndReplay(sender: UIButton) {
      
        let serialQueue = DispatchQueue(label: "queuename", qos: DispatchQoS.userInteractive)
        serialQueue.sync {
            self.gameOverView?.removeFromSuperview()
            self.menuButton?.removeFromSuperview()
            self.aButton?.removeFromSuperview()
            
        }
      
        
        print("Number of deaths when play button is clicked: ", scene?.numberOfDeaths)
        if ((scene?.numberOfDeaths)! <= 1) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showVideoRewardAd"), object: nil)
        
        print("Play ad and replay button clicked")

            if (!(scene?.parentViewController?.adFailedToLoad)!) {
                print("Ad is playing")

        }
            else {
                let alert = UIAlertController(title: "No ads available", message: "Go Back to the Menu and play another round!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Go to Menu", style: .default, handler: {(alert: UIAlertAction!) in self.goToMenu() }))
                
                let root = getCurrentViewController()
                root!.present(alert, animated: true, completion: nil)

            }
            
        
        
        }
        else {
            
            let alert = UIAlertController(title: "Ops! Ad Bonus ended", message: "You can watch one add for an extra life per play", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Go to Menu", style: .default, handler: {(alert: UIAlertAction!) in self.goToMenu() }))
            
            let root = getCurrentViewController()
            root!.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func getCurrentViewController() -> UIViewController? {
        
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
    }
    
    func setCoinLabel(value1: Int, value2: Int) {
        if (value1 == 0) {
            self.coinLabel?.text = String(format: "Coin: %04u / ∞", value2)
        }
        else {
         self.coinLabel?.text = String(format: "Coin: %04u / \(value1)", value2)
        }
    }
    
    func setScoreLabel(value: Int) {
        self.scoreLabel?.text = String(format: "Score: %08u", value)

    }

}
