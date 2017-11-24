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
    
    @IBAction func settingsButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let pageVC = storyboard.instantiateViewController(withIdentifier: "pageView") as! PageViewController
        
        print("Instanciada nova Page View Controller")
        
        self.present(pageVC, animated: false,
                     completion: nil)
        
    }
    var gameVC: GameViewController!
    var bannerView: GADBannerView!
    var enteredFirst = false
    var timer = Timer()
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var totalCoinsLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func startButtonClicked(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
        gameVC = gameVC ?? storyboard.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        gameVC.menu = self
        print("Instanciada nova Game View Controller")
        gameVC.view.backgroundColor = UIColor.black
            
        self.present(gameVC, animated: false,
                         completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserProfile.sharedInstance.loadUserData()
        
        // Do any additional setup after loading the view.
        AudioManager.sharedInstance.playBackgroundMusicMenu()
        
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        
        bannerView.adUnitID = "ca-app-pub-3456908685378113/4905244576"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        addBannerViewToView(bannerView)
        
        updateLabels()
        
        runTimer()
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
        updateLabels()
    }
    
    func updateLabels() {
        
        highScoreLabel.text = "High Score: \(UserProfile.sharedInstance.highScore)"
    
        totalCoinsLabel.text = "Total Coins: \(UserProfile.sharedInstance.coinsTotal)"
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
    func runTimer() {
        
        
        let seconds = 0.5
        timer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: (#selector(changeButtonAlpha)), userInfo: nil, repeats: true)
        
        
    }
    
    func changeButtonAlpha() {
        if (startButton.alpha == 1.0) {
            startButton.alpha = 0.01001
            
        }
        
        else {
        
        startButton.alpha = 1.0
  
        }
        
    }
    
    }
    



