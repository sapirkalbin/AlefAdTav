//
//  AlefIntroViewController.swift
//  AlefAdTav
//
//  Created by Sapir Kalbin on 23/07/2019.
//  Copyright © 2019 Sapir Kalbin. All rights reserved.
//

import UIKit
import AVFoundation

class AlefIntroViewController: UIViewController, AVAudioPlayerDelegate {
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound()

    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // Next VC (Alef Writing)
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "AlefIntro", withExtension: "mp3") else { return }
        
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
