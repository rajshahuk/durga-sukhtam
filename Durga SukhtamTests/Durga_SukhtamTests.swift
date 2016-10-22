//
//  Durga_SukhtamTests.swift
//  Durga SukhtamTests
//
//  Created by Rajesh Shah on 20/10/2016.
//  Copyright © 2016 Rajesh Shah. All rights reserved.
//

import XCTest
@testable import Durga_Sukhtam

class Durga_SukhtamTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmptyStanza() {
        let s = Stanza(englishText: "", sanskritText: "", soundFile: "");
        assert(s.englishText == "")
        assert(s.sanskritText == "")
        assert(s.soundFile == "")
    }
    
    func testStanzaPlayer() {
        let s = StanzaPlayer.sharedInstance.stanzas;
        assert(s.count > 0, "Asserting that the size of stanzas in greater than 0")
        assert(s.count == 15, "Asserting there are 15 stanzas")
    }
    
    func testPlaybankRates() {
        let p = PlaybackRates.sharedInstance.playbackRates
        assert(p.count == 3, "Asserting that there are 3 items in the playback rates:")
        var pp = PlaybackRates.sharedInstance.getCurrentPlaybackRate()
        assert(pp.playbackName == "NORMAL");
        assert(pp.playbackRate == "1.0");
        pp = PlaybackRates.sharedInstance.incrementPlaybackRate();
        assert(pp.playbackName == "FAST");
        assert(pp.playbackRate == "1.25");
        pp = PlaybackRates.sharedInstance.incrementPlaybackRate();
        assert(pp.playbackName == "SLOW");
        assert(pp.playbackRate == "0.75");
        pp = PlaybackRates.sharedInstance.incrementPlaybackRate();
        assert(pp.playbackName == "NORMAL");
        assert(pp.playbackRate == "1.0");
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
