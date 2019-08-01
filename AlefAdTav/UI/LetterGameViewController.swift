//
//  AlefGameViewController.swift
//  AlefAdTav
//
//  Created by Sapir Kalbin on 25/07/2019.
//  Copyright © 2019 Sapir Kalbin. All rights reserved.
//

import UIKit
import AVFoundation


class LetterGameViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var circle1: UIImageView!
    @IBOutlet weak var circle2: UIImageView!
    @IBOutlet weak var circle3: UIImageView!
    @IBOutlet weak var circle4: UIImageView!
    @IBOutlet weak var circle5: UIImageView!
    @IBOutlet weak var peach: UIImageView!
    @IBOutlet weak var letterImage: UIImageView!
    
    var currentLetter = ""
    var answersDictionary: Dictionary = [UIImageView:String]()
    var player: AVAudioPlayer?
    var lastIsRight = false
    var counterRightAnswers = 0
    var endTimer = Timer()
    var gaveFeedback = true
    var soundTimer = Timer()
    var playString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(AppUtility.gender == "girl")
        {
            playString = "click_on_images_female"
        }
        else
        {
            playString = "click_on_images_male"
        }
        
        intializeSoundsTimer(seconds: 0.01)

        currentLetter = AppUtility.currentLetter
        ButtonsTapsHandler()
        intializeAssets()
        setAssets()
    }
    
    func ButtonsTapsHandler() {
        let circle1GestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(circle1Tapped(_:)))
        let circle2GestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(circle2Tapped(_:)))
        let circle3GestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(circle3Tapped(_:)))
        let circle4GestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(circle4Tapped(_:)))
        let circle5GestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(circle5Tapped(_:)))
        
        circle1.isUserInteractionEnabled = true
        circle2.isUserInteractionEnabled = true
        circle3.isUserInteractionEnabled = true
        circle4.isUserInteractionEnabled = true
        circle5.isUserInteractionEnabled = true
        image1.isUserInteractionEnabled = true
        image5.isUserInteractionEnabled = true
        image2.isUserInteractionEnabled = true
        image3.isUserInteractionEnabled = true
        image4.isUserInteractionEnabled = true
        
        circle1.addGestureRecognizer(circle1GestureRecognizer)
        circle2.addGestureRecognizer(circle2GestureRecognizer)
        circle3.addGestureRecognizer(circle3GestureRecognizer)
        circle4.addGestureRecognizer(circle4GestureRecognizer)
        circle5.addGestureRecognizer(circle5GestureRecognizer)
        
        image1.addGestureRecognizer(circle1GestureRecognizer)
        image2.addGestureRecognizer(circle2GestureRecognizer)
        image3.addGestureRecognizer(circle3GestureRecognizer)
        image4.addGestureRecognizer(circle4GestureRecognizer)
        image5.addGestureRecognizer(circle5GestureRecognizer)
        
        
    }
    
    func startEndTimer() {
        endTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(endTimerHandler(_:)), userInfo: nil, repeats: false)
    }
    
    @objc func endTimerHandler(_ timer: Timer) {
        goToViewController(viewcontrollerName: "AllLettersViewController")
    }
    
    private func goToViewController(viewcontrollerName: String)
    {
        if let viewcontroller = storyboard?.instantiateViewController(withIdentifier: viewcontrollerName)
        {
            self.present(viewcontroller, animated: true, completion: nil)
        }
    }
    
    @objc func circle1Tapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        checkAnswer(imageView: circle1)
    }
    
    @objc func circle2Tapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        checkAnswer(imageView: circle2)
    }
    
    @objc func circle3Tapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        checkAnswer(imageView: circle3)
    }
    
    @objc func circle4Tapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        checkAnswer(imageView: circle4)
    }
    
    @objc func circle5Tapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        checkAnswer(imageView: circle5)
    }
    
    func finishGame()
    {
        AppUtility.setProgressLetter(key: AppUtility.currentLetter, progress: 1)

        startEndTimer()
        
        circle1.isUserInteractionEnabled = false
        circle2.isUserInteractionEnabled = false
        circle3.isUserInteractionEnabled = false
        circle4.isUserInteractionEnabled = false
        circle5.isUserInteractionEnabled = false
        
        
    }
    
    @objc func soundTimerHandler(_ timer: Timer) {
        playSound(resourceName: playString)
        soundTimer.invalidate()
    }
    
    func intializeSoundsTimer(seconds: Double) {
        soundTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(soundTimerHandler(_:)), userInfo: nil, repeats: false)
    }
    
    func checkAnswer(imageView: UIImageView)
    {
        guard let correctImages = AppUtility.listOfImagePerLetter[currentLetter] else {return}
        guard let thisWord = answersDictionary[imageView] else {return}
        playSound(resourceName: thisWord + "_sound")
        gaveFeedback = false

        if (correctImages.contains(thisWord))
        {
            counterRightAnswers+=1
            imageView.image = UIImage(named: "correct_circle")
            lastIsRight = true
            if(counterRightAnswers == 2)
            {
                finishGame()
            }
        }
        else
        {
            imageView.image = UIImage(named: "wrong_circle")
            lastIsRight = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.landscapeLeft)
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if(!gaveFeedback)
        {
            if(lastIsRight)
            {
                if(AppUtility.gender == "girl")
                {
                    if(Bool.random())
                    {
                        playSound(resourceName: "good")
                    }
                    else
                    {
                        if(Bool.random())
                        {
                            playSound(resourceName: "correct_sound")
                        }
                        else
                        {
                            playSound(resourceName: "great_female")

                        }
                    }
                }
                else
                {
                    if(Bool.random())
                    {
                        playSound(resourceName: "good")
                    }
                    else
                    {
                        if(Bool.random())
                        {
                            playSound(resourceName: "correct_sound")
                        }
                        else
                        {
                            playSound(resourceName: "great_male")
                        }
                    }
                }
               
            }
            else
            {
                playSound(resourceName: "incorrect_sound")
            }
            
            gaveFeedback = true
        }
    }
    
    func playSound(resourceName: String) {
        guard let url = Bundle.main.url(forResource: resourceName, withExtension: "mp3") else { return }
        
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
    
    func intializeAssets()
    {
        letterImage.image = UIImage(named: AppUtility.currentLetter)
        
        var array = [circle1, circle2, circle3, circle4, circle5]
        let correctAnswer1 = array.randomElement()
        array = array.filter{$0 != correctAnswer1}
        let correctAnswer2 = array.randomElement()
        array = array.filter{$0 != correctAnswer2}
        let wrongAnswer1 = array.randomElement()
        array = array.filter{$0 != wrongAnswer1}
        let wrongAnswer2 = array.randomElement()
        array = array.filter{$0 != wrongAnswer2}
        let wrongAnswer3 = array.randomElement()
        
        var correctImages = AppUtility.listOfImagePerLetter[currentLetter]
        
        if let correctLetterImage = correctImages?.randomElement() as String?
        {
            if let correct = correctAnswer1 as? UIImageView
            {
                answersDictionary[correct] = correctLetterImage
                correctImages = correctImages?.filter{$0 != correctLetterImage}
            }
        }
        
        if let correctLetterImage = correctImages?.randomElement() as String?
        {
            if let correct = correctAnswer2 as? UIImageView
            {
                answersDictionary[correct] = correctLetterImage
                correctImages = correctImages?.filter{$0 != correctLetterImage}
            }
        }
        
        if let wrongLetterImage = AppUtility.listOfImagePerLetter[AppUtility.lettersList.randomElement()!]?.randomElement() as String?
        {
            if let wrong = wrongAnswer1 as? UIImageView
            {
                answersDictionary[wrong] = wrongLetterImage
            }
        }
        if let wrongLetterImage = AppUtility.listOfImagePerLetter[AppUtility.lettersList.randomElement()!]?.randomElement() as String?
        {
            if let wrong = wrongAnswer2 as? UIImageView
            {
                answersDictionary[wrong] = wrongLetterImage
            }
        }
        if let wrongLetterImage = AppUtility.listOfImagePerLetter[AppUtility.lettersList.randomElement()!]?.randomElement() as String?
        {
            if let wrong = wrongAnswer3 as? UIImageView
            {
                answersDictionary[wrong] = wrongLetterImage
            }
        }
    }
    
    func setAssets()
    {
        guard let word1 = answersDictionary[circle1] else {return}
        image1.image = UIImage(named: word1)
        
        guard let word2 = answersDictionary[circle2] else {return}
        image2.image = UIImage(named: word2)
        
        guard let word3 = answersDictionary[circle3] else {return}
        image3.image = UIImage(named: word3)
        
        guard let word4 = answersDictionary[circle4] else {return}
        image4.image = UIImage(named: word4)
        
        guard let word5 = answersDictionary[circle5] else {return}
        image5.image = UIImage(named: word5)
    }
    
    
    
}
