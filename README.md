# AdmobHelper Class
Admob Helper class for swift 4.2 and Xcode 10.1

# Usage

1. Install the   pod 'Google-Mobile-Ads-SDK'
2. Copy this git repo file and drag into your project.
3. Use below lines of code for Banner Ads.
  
  // Take 'let admob = AdMobHelper()' on scope of class.
  
        let admob = AdMobHelper()
        admob.initBannerAds(controller: self)
        admob.loadBannerAds()
4. Use Below code for Intersitial Ads.
  
        admob.initIntersitialAds()
        admob.loadIntersitailAds()
to show Intersitial Ad.

        admob.showIntersitialAd()
