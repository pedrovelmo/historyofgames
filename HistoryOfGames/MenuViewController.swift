//
//  MenuViewController.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 07/10/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MenuViewController: UIViewController, GADBannerViewDelegate {
    
    var gameVC: GameViewController!
    var bannerView: GADBannerView!

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
        
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        
        
        bannerView.adUnitID = "ca-app-pub-3456908685378113/4905244576"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        addBannerViewToView(bannerView)
    
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
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
        
        
        // MARK: GADBannerViewDelegate
        /// Tells the delegate an ad request loaded an ad.
        func adViewDidReceiveAd(_ bannerView: GADBannerView) {
            print("adViewDidReceiveAd")
        }
        
        /// Tells the delegate an ad request failed.
        func adView(_ bannerView: GADBannerView,
                    didFailToReceiveAdWithError error: GADRequestError) {
            print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        }
        
        /// Tells the delegate that a full screen view will be presented in response
        /// to the user clicking on an ad.
        func adViewWillPresentScreen(_ bannerView: GADBannerView) {
            print("adViewWillPresentScreen")
        }
        
        /// Tells the delegate that the full screen view will be dismissed.
        func adViewWillDismissScreen(_ bannerView: GADBannerView) {
            print("adViewWillDismissScreen")
        }
        
        /// Tells the delegate that the full screen view has been dismissed.
        func adViewDidDismissScreen(_ bannerView: GADBannerView) {
            print("adViewDidDismissScreen")
        }
        
        /// Tells the delegate that a user click will open another app (such as
        /// the App Store), backgrounding the current app.
        func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
            print("adViewWillLeaveApplication")
        }
    }
    



