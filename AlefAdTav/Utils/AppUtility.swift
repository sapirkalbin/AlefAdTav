//
//  AppUtility.swift
//  AlefAdTav
//
//  Created by Sapir Kalbin on 15/07/2019.
//  Copyright © 2019 Sapir Kalbin. All rights reserved.
//

import Foundation
import UIKit

struct AppUtility {
    public static var listOfImagePerLetter = ["alef": ["ear", "lion", "pear", "bicycle"], "bet": ["banana", "egg", "thunder", "house"], "gimel": ["carrot", "camel", "girrafe", "cheese"], "daled": ["dolphin", "bear", "honey", "fish"],"hey":["mountain", "hippo", "steering_wheel", "pregnancy"], "vav":["pink", "curtain", "waffles", "rose"],"zain":["fireworks", "beard", "zebra", "gold"], "het":["cat", "menorah", "snail", "pig"],"tet": ["tractor", "tv", "drop", "peacock"], "yod": ["mosquito", "dove", "wine", "owl"],"kaf": ["chair", "ball", "hat", "dog"], "lamed":["heart", "bun", "whale", "lemon"], "mem": ["umbrella", "camera", "bed", "sunglasses"], "nun": ["hotdog", "candle", "snake", "shoes"],
                                              "samech": ["spinning_top", "squirrel", "books", "horse"] ,"ain": ["kite", "circle", "bone", "eyes"],"pey":["flashlight", "butterfly", "cow", "hammer"] , "zadi": ["shell", "turtle", "chips", "cotton_candy"],"kuf":["kangoroo", "coconut", "rainbow", "pencil_case"] ,"reish":["pomegrant", "traffic_lights", "doctor", "legs"],"shin":["garlic", "chocolate", "remote", "legs"],"tav":["apple", "baby", "parrot", "drums"]]
    
    public static var lettersList = ["alef", "bet", "gimel","daled","hey", "vav","zain", "het","tet", "yod","kaf", "lamed","mem", "nun",
                                          "samech","ain","pey", "zadi","kuf","reish","shin","tav"]
    
    public static var gender = ""
    public static var currentLetter = ""

    static func setProgressLetter(key: String, progress: Float)
    {
        let defaults = UserDefaults.standard
        defaults.set(progress, forKey: key)
    }
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
}
