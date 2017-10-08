//
//  MenuViewController.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 07/10/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBAction func easyButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let gameVC: GameViewController = storyboard.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        gameVC.gameMode = "easy"
        gameVC.view.backgroundColor = UIColor.black
        
        self.present(gameVC, animated: false,
                     completion: nil)
    }
    @IBAction func mediumButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let gameVC: GameViewController = storyboard.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        gameVC.gameMode = "medium"
        gameVC.view.backgroundColor = UIColor.black
        
        self.present(gameVC, animated: false,
                     completion: nil)
        
    }
    
    @IBAction func hardButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let gameVC: GameViewController = storyboard.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        gameVC.gameMode = "hard"
        gameVC.view.backgroundColor = UIColor.black
        
        self.present(gameVC, animated: false,
                     completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
