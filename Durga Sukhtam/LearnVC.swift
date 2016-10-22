//
//  LearnVC.swift
//  Durga Sukhtam
//
//  Created by Rajesh Shah on 21/10/2016.
//  Copyright © 2016 Rajesh Shah. All rights reserved.
//

import UIKit
import AVFoundation

class LearnVC: UIViewController, AVAudioPlayerDelegate {
    
    
    //MARK: UI Stuff
    @IBOutlet weak var stanzaLabel: UILabel!
    @IBOutlet weak var englishTextView: UITextView!
    @IBOutlet weak var sanskritTextView: UITextView!
    @IBOutlet weak var playPauseButton: UIBarButtonItem!
    
    //MARK: Model needed for view
    let stanzas = StanzaPlayer.sharedInstance.stanzas;
    var currentIndex = 0;
    
    var audioPlayer = AVAudioPlayer();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title! = "Learn"
        loadStanzaIntoView(index: currentIndex)
        
        setupAudioPlayer()
        
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
        let isPlaying = audioPlayer.isPlaying;
        setupAudioPlayer()
        if (isPlaying) {
            audioPlayer.play()
        }
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
        let isPlaying = audioPlayer.isPlaying;
        setupAudioPlayer()
        if (isPlaying) {
            audioPlayer.play()
        }

    }
    
    // MARK: UI actions
    @IBAction func playButtonPressed(_ sender: UIBarButtonItem) {
        print("Play Pressed")
        if (audioPlayer.isPlaying) {
            audioPlayer.pause();
            self.playPauseButton.image = #imageLiteral(resourceName: "play-button-bar")
        }
        else {
            audioPlayer.play();
            self.playPauseButton.image = #imageLiteral(resourceName: "pause-button-bar")
        }
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
    
    func setupAudioPlayer() {
        let path = Bundle.main.path(forResource: stanzas[currentIndex].soundFile + ".mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        }
        catch {
            print(error)
        }
        
    }
    
}

