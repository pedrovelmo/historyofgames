//
//  GameViewController.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 31/08/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds

class GameViewController: UIViewController, GADRewardBasedVideoAdDelegate {
    
    
    var menu: MenuViewController!
    
    var scene: GameScene!
    
    var gameOverAlreadyHappened = false
    
    var rewardVideoAdPlayed = false
    
    override func viewWillAppear(_ animated: Bool) {
        // self.view.backgroundColor = UIColor.black
        if (!gameOverAlreadyHappened) {
        createLoadingView()
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scene = GameScene(size: view.bounds.size)
        print("Instancia cena")
        AudioManager.sharedInstance.stopBackgroundMusic()
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.startVideoAd), name: NSNotification.Name(rawValue: "showVideoRewardAd"), object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Game Over Happened: ", gameOverAlreadyHappened)

    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func startVideoAd() {
        //        scene?.isGameOver = false
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
        
    }
    
    func presentGameScene() {
        if let view = self.view as! SKView? {
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            scene.menu = menu
            scene.parentViewController = self
            //  scene.gameDelegate = self
            
            // Present the scene
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = true
            view.showsPhysics = false
        }
    }
    

    
    func createLoadingView() {
        let loadingView = UIView(frame: CGRect(x: self.view.frame.width / 2 - 120, y: self.view.frame.height / 2 - 20 , width: 0, height: 40))
        
        UIView.animate(withDuration: 2.0,
                       animations: {
                        loadingView.frame.size = CGSize(width: 250, height: 40)
                        loadingView.backgroundColor = UIColor.blue
        },
                       completion: { finished in
                        if(finished) {
                            
                            loadingView.removeFromSuperview()
                            self.presentGameScene()
                            
                        }
        }
        )
        
        
        self.view?.addSubview(loadingView)
        
    }
    
    func launchViewController(scene: SKScene) {
        gameOverAlreadyHappened = false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let menuVC: MenuViewController = storyboard.instantiateViewController(withIdentifier: "menuVC") as! MenuViewController
        
        scene.removeFromParent()
        
        self.present(menuVC, animated: false,
                     completion: self.removeFromParentViewController)
        
    }
    
    // MARK: Reward video ad delegate
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        print("Reward video played")
        rewardVideoAdPlayed = true
        
        
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        print("Reward based video ad is received.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
        if (rewardVideoAdPlayed) {
            scene?.isGameOver = false
            scene?.player.alpha = 1.0
            presentGameScene()
            
        }
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load.")
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
    
}

