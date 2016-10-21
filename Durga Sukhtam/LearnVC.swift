//
//  LearnVC.swift
//  Durga Sukhtam
//
//  Created by Rajesh Shah on 21/10/2016.
//  Copyright © 2016 Rajesh Shah. All rights reserved.
//

import UIKit

class LearnVC: UIViewController {
    
    
    //MARK: UI Stuff
    @IBOutlet weak var stanzaLabel: UILabel!
    @IBOutlet weak var englishTextView: UITextView!
    @IBOutlet weak var sanskritTextView: UITextView!
    
    //MARK: Model needed for view
    let stanzas = StanzaPlayer.sharedInstance.stanzas;
    var currentIndex = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title! = "Learn"
        loadStanzaIntoView(index: currentIndex)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadStanzaIntoView(index: Int)  {
        let s = stanzas[index];
        stanzaLabel.text = "Verse: \(index + 1) / \(stanzas.count)";
        englishTextView.text = s.englishText;
        sanskritTextView.text = s.sanskritText;
    }
    
    // MARK: UI actions
    @IBAction func playButtonPressed(_ sender: UIBarButtonItem) {
        print("Play Pressed");
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIBarButtonItem) {
        print("Forward Pressed")
        if (currentIndex < stanzas.count-1) {
            currentIndex += 1;
        }
        else {
            currentIndex = 0;
        }
        loadStanzaIntoView(index: currentIndex)
    }
    
    @IBAction func remindButtonPressed(_ sender: UIBarButtonItem) {
        print("Rewind Pressed")
        if (currentIndex > 0) {
            currentIndex -= 1;
        }
        else {
            currentIndex = stanzas.count-1;
        }
        loadStanzaIntoView(index: currentIndex)
    }
    
}

