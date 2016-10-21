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
        StanzaPlayer.sharedInstance;
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
