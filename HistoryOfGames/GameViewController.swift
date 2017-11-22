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


class GameViewController: UIViewController {
    
    
    var menu: MenuViewController!
    
    var scene: GameScene!
    
    override func viewWillAppear(_ animated: Bool) {
        // self.view.backgroundColor = UIColor.black
        createLoadingView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AudioManager.sharedInstance.stopBackgroundMusic()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
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
    
    func presentGameScene() {
        if let view = self.view as! SKView? {
            
            scene = GameScene(size: view.bounds.size)
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
            view.showsPhysics = true
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let menuVC: MenuViewController = storyboard.instantiateViewController(withIdentifier: "menuVC") as! MenuViewController
        
        scene.removeFromParent()
        
        self.present(menuVC, animated: false,
                     completion: self.removeFromParentViewController)
        
    }
    
}

