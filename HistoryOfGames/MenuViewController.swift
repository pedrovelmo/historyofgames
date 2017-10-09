//
//  MenuViewController.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 07/10/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var gameVC: GameViewController!

    @IBAction func easyButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
         gameVC  = storyboard.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        gameVC.gameMode = "easy"
        gameVC.menu = self
        gameVC.view.backgroundColor = UIColor.black
        
        self.present(gameVC, animated: false,
                     completion: nil)
    }
    @IBAction func mediumButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
         gameVC = storyboard.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        gameVC.gameMode = "medium"
        gameVC.menu = self
        gameVC.view.backgroundColor = UIColor.black
        
        self.present(gameVC, animated: false,
                     completion: nil)
        
    }
    
    @IBAction func hardButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
         gameVC = storyboard.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        gameVC.gameMode = "hard"
        gameVC.menu = self
        gameVC.view.backgroundColor = UIColor.black
        
        self.present(gameVC, animated: false,
                     completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        AudioManager.sharedInstance.playBackgroundMusicMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func killAll() {
        gameVC.scene.view?.presentScene(nil)
        gameVC.dismiss(animated: true, completion: nil)
        AudioManager.sharedInstance.stopBackgroundMusic()
        AudioManager.sharedInstance.playBackgroundMusicMenu()
        
    }
    


//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        let gameVC = segue.destination as! GameViewController
//         if segue.identifier == "easySegue" {
//            gameVC.gameMode = "easy"
//        }
//        
//         else if segue.identifier == "mediumSegue" {
//           gameVC.gameMode = "medium"
//            
//    }
//         else {
//            gameVC.gameMode = "hard"
//
//            }
//
//    }
    
}
