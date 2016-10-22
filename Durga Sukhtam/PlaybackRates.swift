//
//  PlaybackRates.swift
//  Durga Sukhtam
//
//  Created by Rajesh Shah on 22/10/2016.
//  Copyright © 2016 Rajesh Shah. All rights reserved.
//

import Foundation
import UIKit

class PlaybackRates {
    
    static let sharedInstance : PlaybackRates =  {
        let instance = PlaybackRates()
        return instance
    }()
    
    var playbackRates = [PlaybackRate]();
    
    private var currentIndex = 0;
    
    //MARK: Initialisation
    
    private init() {
        
        let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String]! as! String
        
        if let path = Bundle.main.path(forResource: appName, ofType: "plist"),
            let plistData = NSDictionary(contentsOfFile: path) {
            let label = plistData.value(forKey: "playbackRateLabel") as! NSArray
            let rate  = plistData.value(forKey: "playbackRate") as! NSArray
            
            var i = 0;
            for _ in rate {
                
                let p = PlaybackRate(playbackName: label[i] as! String, playbackRate: rate[i] as! String)
                
                playbackRates.append(p);
                i += 1;
            }
        }
    }
    
    func getCurrentPlaybackRate() -> PlaybackRate {
        return playbackRates[currentIndex];
    }
    
    func incrementPlaybackRate() -> PlaybackRate {
        if (currentIndex < playbackRates.count-1) {
            currentIndex += 1
        }
        else {
            currentIndex = 0;
        }
        return getCurrentPlaybackRate()
    }
    
    
}
