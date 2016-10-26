//
//  LearnVC.swift
//  Durga Sukhtam
//
//  Created by Rajesh Shah on 21/10/2016.
//  Copyright © 2016 Rajesh Shah. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class LearnVC: UIViewController, AVAudioPlayerDelegate {
    
    
    //MARK: UI Stuff
    @IBOutlet weak var stanzaLabel: UILabel!
    @IBOutlet weak var englishTextView: UITextView!
    @IBOutlet weak var sanskritTextView: UITextView!
    @IBOutlet weak var playPauseButton: UIBarButtonItem!
    @IBOutlet weak var repeatButton: UIBarButtonItem!
    @IBOutlet weak var playRateLabel: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    
    //MARK: Model needed for view
    let stanzas = StanzaPlayer.sharedInstance.stanzas
    var currentIndex = 0
    var isRepeating = false
    var isPlaying = false
    var audioPlayer = AVAudioPlayer();
    
    // background
    var gradientLayer: CAGradientLayer!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createGradientLayer()
        self.becomeFirstResponder()
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title! = "Learn"
        loadStanzaIntoView(index: currentIndex)
        
        playRateLabel.title = PlaybackRates.sharedInstance.getCurrentPlaybackRate().playbackName
        
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
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        let eventSubtype = event!.subtype
        if (event!.type == UIEventType.remoteControl) {
            switch eventSubtype {
            case UIEventSubtype.remoteControlTogglePlayPause:
                playPauseToggled()
                break
            case UIEventSubtype.remoteControlPlay:
                playPauseToggled()
                break
            case UIEventSubtype.remoteControlPause:
                playPauseToggled()
                break
            case UIEventSubtype.remoteControlStop:
                playPauseToggled()
                break
            case UIEventSubtype.remoteControlNextTrack:
                next()
                break
            case UIEventSubtype.remoteControlPreviousTrack:
                previous()
                break
            default:
                break
            }
        }
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

        setupAudioPlayer()
        if (isPlaying) {
            audioPlayer.play()
        }

    }
    
    func playPauseToggled() {
        if (audioPlayer.isPlaying) {
            audioPlayer.pause()
            self.isPlaying = false;
            self.playPauseButton.image = #imageLiteral(resourceName: "play-button-bar")
        }
        else {
            audioPlayer.play()
            self.isPlaying = true;
            self.playPauseButton.image = #imageLiteral(resourceName: "pause-button-bar")
        }
    }
    
    // MARK: UI actions
    @IBAction func playButtonPressed(_ sender: UIBarButtonItem) {
        print("Play Pressed")
        playPauseToggled()
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIBarButtonItem) {
        print("Forward Pressed")
        next()
    }
    
    @IBAction func remindButtonPressed(_ sender: UIBarButtonItem) {
        print("Rewind Pressed")
        previous()
    }
    
    @IBAction func repeatButtonPressed(_ sender: UIBarButtonItem) {
        self.isRepeating = !self.isRepeating
        if (self.isRepeating) {
            repeatButton.tintColor = UIColor.darkGray
        }
        else {
            repeatButton.tintColor = self.playPauseButton.tintColor
        }
        
    }
    
    @IBAction func playRateButtonPressed(_ sender: UIBarButtonItem) {
        let p = PlaybackRates.sharedInstance.incrementPlaybackRate()
        playRateLabel.title = p.playbackName
        print("New playback rate: \(p.playbackRate)")
        self.audioPlayer.rate = p.floatValue();
    }
    
    func handleSwipes(sender :UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            next()
        }
        if (sender.direction == .right) {
            previous()
        }
    }
    
    func setupAudioPlayer() {
        let path = Bundle.main.path(forResource: stanzas[currentIndex].soundFile + ".mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            audioPlayer.enableRate = true
            audioPlayer.prepareToPlay()
            self.setLockScreenDetails()
        }
        catch {
            print(error)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if (!isRepeating) {
            self.next()
        }
        else {
            if (isPlaying) {
                self.setupAudioPlayer()
                audioPlayer.play()
            }
        }
    }
    
    func setLockScreenDetails() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo =
            [MPMediaItemPropertyArtist : "12nines.com",
             MPMediaItemPropertyTitle : stanzaLabel.text!,
             MPMediaItemPropertyAlbumTitle : "Durga Sukhtam"]
    }
    
    
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.yellow.cgColor]
//        gradientLayer.below
        self.view.layer.insertSublayer(gradientLayer, below: toolbar.layer)
    }
    
}

