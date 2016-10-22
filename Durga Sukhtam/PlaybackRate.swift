//
//  PlaybackRate.swift
//  Durga Sukhtam
//
//  Created by Rajesh Shah on 22/10/2016.
//  Copyright © 2016 Rajesh Shah. All rights reserved.
//

import Foundation

struct PlaybackRate {
    
    let playbackName, playbackRate: String
    
    init(playbackName: String, playbackRate: String) {
        self.playbackName = playbackName
        self.playbackRate = playbackRate
    }
    
    func floatValue() -> Float {
        return NumberFormatter().number(from: playbackRate)!.floatValue
    }
}
