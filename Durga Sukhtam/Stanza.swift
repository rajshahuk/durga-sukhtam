//
//  Stanza.swift
//  Durga Sukhtam
//
//  Created by Rajesh Shah on 21/10/2016.
//  Copyright © 2016 Rajesh Shah. All rights reserved.
//

import Foundation

struct Stanza {
    
    let englishText, sanskritText, soundFile: String
    
    init(englishText: String, sanskritText: String, soundFile: String) {
        self.englishText = englishText
        self.sanskritText = sanskritText
        self.soundFile = soundFile
    }
    
}
