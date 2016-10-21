//
//  LearnVC.swift
//  Durga Sukhtam
//
//  Created by Rajesh Shah on 21/10/2016.
//  Copyright © 2016 Rajesh Shah. All rights reserved.
//

import UIKit

class LearnVC: UIViewController {
    
    @IBOutlet weak var stanzaLabel: UILabel!
    
    @IBOutlet weak var englishTextView: UITextView!
    
    @IBOutlet weak var sanskritTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title! = "Learn"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playButtonPressed(_ sender: UIBarButtonItem) {
        print("Play Pressed");
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIBarButtonItem) {
        print("Forward Pressed")
    }
    
    @IBAction func remindButtonPressed(_ sender: UIBarButtonItem) {
        print("Rewind Pressed")
    }
    
}

