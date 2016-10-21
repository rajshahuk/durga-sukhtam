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
        
        // swipes stuff
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
        
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
    
    func next() {
        if (currentIndex < stanzas.count-1) {
            currentIndex += 1;
        }
        else {
            currentIndex = 0;
        }
        loadStanzaIntoView(index: currentIndex)
        UIView.transition(with: sanskritTextView, duration: 1, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: nil, completion: nil)
        UIView.transition(with: englishTextView, duration: 1, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    func previous() {
        if (currentIndex > 0) {
            currentIndex -= 1;
        }
        else {
            currentIndex = stanzas.count-1;
        }
        loadStanzaIntoView(index: currentIndex)
        UIView.transition(with: sanskritTextView, duration: 1, options: UIViewAnimationOptions.transitionFlipFromRight, animations: nil, completion: nil)
        UIView.transition(with: englishTextView, duration: 1, options: UIViewAnimationOptions.transitionFlipFromRight, animations: nil, completion: nil)

    }
    
    // MARK: UI actions
    @IBAction func playButtonPressed(_ sender: UIBarButtonItem) {
        print("Play Pressed")
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIBarButtonItem) {
        print("Forward Pressed")
        next()
    }
    
    @IBAction func remindButtonPressed(_ sender: UIBarButtonItem) {
        print("Rewind Pressed")
        previous()
    }
    
    func handleSwipes(sender :UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            previous()
        }
        if (sender.direction == .right) {
            next()
        }
        
    }
    
}

