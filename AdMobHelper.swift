//
//  AdMobHelper.swift
//
//  Created by Muhamad Rizwan on 05/04/2019.
//

import Foundation
import GoogleMobileAds

class AdMobHelper:NSObject {
    
    fileprivate var bannerAdUnit = "Your Admob Banner ID"
    fileprivate var intersitialAdUnit = "Your Admob Account Intersitial ID"
    fileprivate var rewardedAdUnit = "Your Admob Rewarded Add ID"

    
    fileprivate var bannerView: GADBannerView!
    fileprivate var interstitial: GADInterstitial!

    fileprivate var controller: UIViewController!
    
    
    func initBannerAds(controller: UIViewController) {
        self.controller = controller
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.delegate = self
        bannerView.adUnitID = bannerAdUnit
        bannerView.rootViewController = self.controller
        
        addBannerViewToView(bannerView, cont:self.controller)
    }
    
    func loadBannerAds() {
        let adRequest = GADRequest()
        //Commit this line whengoing to live.
        adRequest.testDevices = [kGADSimulatorID, "87e333b4fe153f14d9e2c76e1f28a440078a47fbs"]
        bannerView.load(adRequest)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView, cont:UIViewController) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        cont.view.addSubview(bannerView)
        cont.view.bringSubview(toFront: bannerView)
        cont.view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: cont.bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: cont.view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    func initIntersitialAds(Controller: UIViewController) {
        interstitial = GADInterstitial(adUnitID: intersitialAdUnit)
        interstitial.delegate = self
    }
    
    func loadIntersitailAds()  {
        let request = GADRequest()
        //Commit this line when going to live.
        request.testDevices = [kGADSimulatorID, "87e333b4fe153f14d9e2c76e1f28a440078a47fbs"]
        self.interstitial.load(request)
    }
    
    func showIntersitialAd() {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: controller)
        } else {
            print("Ad wasn't ready")
        }
    }
}

extension AdMobHelper: GADBannerViewDelegate{
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        addBannerViewToView(bannerView, cont: controller)
        
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
        
    }
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    
}

extension AdMobHelper:GADInterstitialDelegate {
    
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
        loadIntersitailAds()
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
}
