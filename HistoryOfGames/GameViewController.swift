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
    
    var timer = Timer()
    
    var gameOverAlreadyHappened = false
    
    var rewardVideoAdPlayed = false
    
    var adFailedToLoad = false

    
    override func viewWillAppear(_ animated: Bool) {
        // self.view.backgroundColor = UIColor.black
        if (!gameOverAlreadyHappened) {
        createLoadingView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        AudioManager.sharedInstance.stopBackgroundMusic()
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.startVideoAd), name: NSNotification.Name(rawValue: "showVideoRewardAd"), object: nil)

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Game Over Happened: ", gameOverAlreadyHappened)
        print(#function)
        if (!gameOverAlreadyHappened) {
        scene = GameScene(size: view.bounds.size)
        }
        
        else {
            scene.isGameOver = false
            if let hudView = scene.hudView {
                if let gameOver = hudView.gameOverView {
                    gameOver.removeFromSuperview()
                }
                if let menuButton = hudView.menuButton {
                    menuButton.removeFromSuperview()
                }
                if let adButton = hudView.aButton {
                    adButton.removeFromSuperview()
                }
                
            }
        }
        
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID,                       // All simulators
            "b0ef8c411b1165d1bdeb146215e061ed"];
        GADRewardBasedVideoAd.sharedInstance().load(request,
                                                    withAdUnitID: "ca-app-pub-3456908685378113/4475805050")

    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone || UIDevice.current.userInterfaceIdiom == .pad  {
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
            view.showsNodeCount = false
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
                            
                            if (UserProfile.sharedInstance.firstLogin) {
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                
                                let pageVC = storyboard.instantiateViewController(withIdentifier: "pageView") as! PageViewController

                                print("Instanciada nova Page View Controller")
                               
                                self.present(pageVC, animated: false,
                                             completion: nil)
                            }
                            
                            else {
                                self.presentGameScene()
                            }
                            
                        }
            }
        )
        
        
        self.view?.addSubview(loadingView)
        
    }
    
    func launchViewController(scene: SKScene) {
        gameOverAlreadyHappened = false
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let menuVC: MenuViewController = storyboard.instantiateViewController(withIdentifier: "menuVC") as! MenuViewController
        
        scene.removeFromParent()
        self.present(menu, animated: false,
                     completion: self.removeFromParentViewController)
        
    }
    
    // MARK: Reward video ad delegate
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        print("Reward video played")
        rewardVideoAdPlayed = true
        
        
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        print("Reward based video ad is received.")
        adFailedToLoad = false
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
        adFailedToLoad = false
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
            rewardVideoAdPlayed = false
            
        }
        
        else {
            scene?.isGameOver = false
            scene?.killAll()
            scene?.parentViewController?.launchViewController(scene: scene!)
        }
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load.")
        adFailedToLoad = true
    
  
        
    }
    
 

}

