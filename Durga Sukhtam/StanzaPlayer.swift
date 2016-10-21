//
//  StanzaPlayer.swift
//  Durga Sukhtam
//
//  Created by Rajesh Shah on 21/10/2016.
//  Copyright © 2016 Rajesh Shah. All rights reserved.
//

import Foundation
import UIKit

class StanzaPlayer {
    
    static let sharedInstance : StanzaPlayer =  {
        let instance = StanzaPlayer()
        return instance
    }()
    
    var stanzas = [Stanza]();
    
    //MARK: Initialisation
    
    private init() {
        
        if let path = Bundle.main.path(forResource: "durga-sukhtam", ofType: "plist"),
            let stanzaData = NSDictionary(contentsOfFile: path) {
            let eng = stanzaData.value(forKey: "english") as! NSArray
            let san = stanzaData.value(forKey: "sanskrit") as! NSArray
            let mp3 = stanzaData.value(forKey: "stanzamp3") as! NSArray
            var i = 0;
            for _ in eng {
                let s = Stanza(englishText: eng[i] as! String,
                               sanskritText: san[i] as! String,
                               soundFile: mp3[i] as! String);
                print("s = \(s)")
                stanzas.append(s);
                i += 1;
            }
        }
    
    }
    
    
}
