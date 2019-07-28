//
//  AlefIntroViewController.swift
//  AlefAdTav
//
//  Created by Sapir Kalbin on 23/07/2019.
//  Copyright © 2019 Sapir Kalbin. All rights reserved.
//

import UIKit
import AVFoundation

class LetterIntroViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var homeButton: UIImageView!
    @IBOutlet weak var nextButton: UIImageView!
    var numOfImagesDictionary = ["alef": 3, "bet": 2, "gimel": 4, "daled": 2,"hey":3, "vav":2,"zain":2, "het":3,"tet": 4, "yod": 2,"kaf": 3, "lamed":4, "mem": 4, "nun": 3,
                                 "samech": 2 ,"ain": 3,"pey":5 , "zadi": 3,"kuf":3 ,"reish":2,"shin":4,"tav":4]
    var player: AVAudioPlayer?
    var currentLetter: String = ""
    var soundTimer = Timer()
    var imagesTimer = Timer()
    var imagesCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentLetter = AppUtility.currentLetter
        
        intializeSoundsTimer(seconds: 2)
        intializeImagesTimer()
        
        mainImage.image = UIImage(named: currentLetter)
        ButtonsTapsHandler()
    }
    
    
    @objc func soundTimerHandler(_ timer: Timer) {
        playSound()
        soundTimer.invalidate()
    }
    
    @objc func imagesTimerHandler(_ timer: Timer) {
        if let numberOfImages = numOfImagesDictionary[currentLetter] {
            if(imagesCounter == numberOfImages)
            {
                imagesTimer.invalidate()
            }
            else
            {
                mainImage.image = UIImage(named: currentLetter+String(imagesCounter))
            }
        }
        imagesCounter+=1
    }
    
    func intializeSoundsTimer(seconds: Double) {
        soundTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(soundTimerHandler(_:)), userInfo: nil, repeats: false)
    }
    
    func intializeImagesTimer() {
        var _repeat = true
        if let numberOfImages = numOfImagesDictionary[currentLetter] {
            if(imagesCounter == numberOfImages)
            {
                _repeat = false
            }
            imagesTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(imagesTimerHandler(_:)), userInfo: nil, repeats: _repeat)
            
        }
        
        
        
    }
    
    func ButtonsTapsHandler() {
        let homeBtnTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(homeTapped(_:)))
        let nextBtnTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(nextTapped(_:)))
        
        
        homeButton.isUserInteractionEnabled = true
        nextButton.isUserInteractionEnabled = true
        
        homeButton.addGestureRecognizer(homeBtnTapGestureRecognizer)
        nextButton.addGestureRecognizer(nextBtnTapGestureRecognizer)
    }
    
    
    
    
    @objc func homeTapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        goToViewController(viewcontrollerName: "SubjectViewController")
    }
    
    @objc func nextTapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        goToViewController(viewcontrollerName: "LetterWritingViewController")
        AppUtility.setProgressLetter(key: AppUtility.currentLetter, progress: 0.333)
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // Next VC (Alef Writing)
    }
    private func goToViewController(viewcontrollerName: String)
    {
        if let viewcontroller = storyboard?.instantiateViewController(withIdentifier: viewcontrollerName)
        {
            self.present(viewcontroller, animated: true, completion: nil)
        }
    }
    
    private func goToWritingViewController(viewcontrollerName: String)
    {
        if let viewcontroller = storyboard?.instantiateViewController(withIdentifier: viewcontrollerName) as? LetterWritingViewController
        {
            self.present(viewcontroller, animated: true, completion: nil)
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: currentLetter, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            guard let player = player else { return }
            
            player.delegate = self
            player.play()
            
            
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
