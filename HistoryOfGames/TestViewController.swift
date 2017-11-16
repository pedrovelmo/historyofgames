//
//  TestViewController.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 14/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import UIKit
import GoogleMobileAds

class TestViewController: UIViewController, GADBannerViewDelegate, GADInterstitialDelegate, GADRewardBasedVideoAdDelegate {

    
//    @IBOutlet weak var Adview: UIView!
//
//    lazy var adBannerView: GADBannerView = {
//        let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerLandscape)
//        adBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
//        adBannerView.delegate = self
//        adBannerView.rootViewController = self
//
//        return adBannerView
//    }()
    
    var interstitial: GADInterstitial!
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    @IBAction func showAd(_ sender: Any) {
//        if interstitial.isReady {
//            print("Presenting ad")
//            interstitial.present(fromRootViewController: self)
//        } else {
//            print("Ad wasn't ready")
//        }
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
//        let request = GADRequest()
////        request.testDevices = [kGADSimulatorID]
//        adBannerView.load(request)
        
        // Interstitial
//        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
//        interstitial.delegate = self
//        let request = GADRequest()
//        interstitial.load(request)
       
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        print("Banner loaded successfully")
//        Adview.frame = adBannerView.frame
//        Adview = adBannerView
//
//    }
//
//    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
//        print("Fail to receive ads")
//        print(error)
//    }
    
    /// Tells the delegate an ad request succeeded. - Interstitial
//    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
//        print("interstitialDidReceiveAd")
//    }
//
//    /// Tells the delegate an ad request failed.
//    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
//        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
//    }
//
//    /// Tells the delegate that an interstitial will be presented.
//    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
//        print("interstitialWillPresentScreen")
//    }
//
//    /// Tells the delegate the interstitial is to be animated off the screen.
//    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
//        print("interstitialWillDismissScreen")
//    }
//
//    /// Tells the delegate the interstitial had been animated off the screen.
//    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
//        print("interstitialDidDismissScreen")
//    }
//
//    /// Tells the delegate that a user click will open another app
//    /// (such as the App Store), backgrounding the current app.
//    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
//        print("interstitialWillLeaveApplication")
//    }
//
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
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
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load.")
    }

}
