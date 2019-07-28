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
    var numOfImagesDictionary = ["alef": 3, "beit": 3, "gimel": 3, "daled": 2,"hey":3, "vav":2,"zain":2, "heit":3,"tet": 3, "yod": 2,"kaf": 3, "lamed":3, "mem": 4, "nun": 3,
                                 "samech": 2 ,"ain": 3,"pey":5 , "zadi": 3,"kuf":3 ,"reish":2,"shin":4,"tav":4]
    var player: AVAudioPlayer?
    var currentLetter: String = ""
    var soundTimer = Timer()
    var imagesTimer = Timer()
    var imagesCounter = 1
    
    var imagesTimesDictionary = ["alef": [3.0, 4.0,5.0], "beit": [3.0, 4.0,5.0], "gimel": [3.0, 4.0,5.0], "daled": [3.0, 4.0],"hey":[3.0, 4.0,5.0], "vav":[3.0, 4.0],"zain":[3.0, 4.0], "heit":[3.0, 4.0,5.0],"tet": [3.0, 4.0,5.0], "yod": [3.0, 4.0],"kaf": [3.0, 4.0,5.0], "lamed":[3.0, 4.0,5.0], "mem": [3.0, 4.0,5.0, 6.0], "nun": [3.0, 4.0,5.0], "samech": [3.0, 4.0] ,"ain": [3.0, 4.0,5.0],"pey":[3.0, 4.0,5.0, 6.0,7.0] , "zadi": [3.0, 4.0,5.0],"kuf":[3.0, 4.0,5.0] ,"reish":[3.0, 4.0],"shin":[3.0, 4.0,5.0, 6.0],"tav":[3.0, 4.0,5.0, 6.0]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intializeSoundsTimer(seconds: 3)
        intializeImagesTimer()
        
        mainImage.image = UIImage(named: currentLetter)
        ButtonsTapsHandler()
    }
    
    
    @objc func soundTimerHandler(_ timer: Timer) {
        playSound()
        soundTimer.invalidate()
    }
    
    @objc func imagesTimerHandler(_ timer: Timer) {
        mainImage.image = UIImage(named: currentLetter+String(imagesCounter))
        if let array = imagesTimesDictionary[currentLetter] {
            if(imagesCounter == array.count)
            {
                imagesTimer.invalidate()
            }
        }
    }
    
    func intializeSoundsTimer(seconds: Double) {
        soundTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(soundTimerHandler(_:)), userInfo: nil, repeats: false)
    }
    
    func intializeImagesTimer() {
        var _repeat = true
        if let array = imagesTimesDictionary[currentLetter] {
            if(imagesCounter == array.count)
            {
                _repeat = false
            }
            imagesTimer = Timer.scheduledTimer(timeInterval: array[imagesCounter], target: self, selector: #selector(imagesTimerHandler(_:)), userInfo: nil, repeats: _repeat)
            
        }
        
        imagesCounter+=1
        
        
    }
    
    func ButtonsTapsHandler() {
        let homeBtnTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(homeTapped(_:)))
        let nextBtnTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(nextTapped(_:)))
        
        
        homeButton.isUserInteractionEnabled = true
        nextButton.isUserInteractionEnabled = true
        
        homeButton.addGestureRecognizer(homeBtnTapGestureRecognizer)
        nextButton.addGestureRecognizer(nextBtnTapGestureRecognizer)
    }
    
    func setLetter(letter: String){
        self.currentLetter = letter
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // Next VC (Alef Writing)
    }
    
    @objc func homeTapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        goToViewController(viewcontrollerName: "SubjectViewController")
    }
    
    @objc func nextTapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        goToViewController(viewcontrollerName: "AlefWritingViewController")
    }
    
    private func goToViewController(viewcontrollerName: String)
    {
        if let viewcontroller = storyboard?.instantiateViewController(withIdentifier: viewcontrollerName)
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
