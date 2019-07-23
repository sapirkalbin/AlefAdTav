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
    public static let AlefImages: [String] = ["closet", "ear", "lion", "pear", "watermelon"];
    public static let BetImages: [String] = ["banana", "egg", "house"];
    public static let GimelImages: [String] = ["fence"];
    public static let DaledImages: [String] = ["fish"];
    public static let HeyImages: [String] = ["hippo", "mountain", "pregnancy", "steering_wheel"];
    public static let VavImages: [String] = ["curtain", "pink", "rose", "waffle"];
    public static let ZainImages: [String] = ["beard", "fireworks", "fly", "gold", "old"];
    public static let HetImages: [String] = ["cat", "menorah", "pig", "skirt", "snail"];
    public static let TetImages: [String] = ["drop", "peacock", "telephone", "tractor", "tv"];
    public static let YodImages: [String] = ["dove", "mosquito", "owl", "sea", "wine"];
    public static let KafImages: [String] = ["ball", "chair", "dog", "hat", "money"];
    public static let LamedImages: [String] = ["bun", "heart", "lemon", "night", "whale"];
    public static let MemImages: [String] = ["bed", "camera", "mirror", "sunglasses", "umbrella"];
    public static let NunImages: [String] = ["candle", "hotdog", "princess", "shoes", "shake"];
    public static let SamechImages: [String] = ["books", "horse", "knife", "spinning_top", "squirrel"];
    public static let AinImages: [String] = ["bone", "circle", "eyes", "kite", "plant"];
    public static let PeyImages: [String] = ["butterfly", "cow", "flashlight", "hammer", "pj"];
    public static let ZadiImages: [String] = ["cotton_candy", "fries", "scarf", "shell", "turtle"];
    public static let KufImages: [String] = ["kangaroo", "monkey", "pencil_case", "rainbow", "rhino"];
    public static let ReishImages: [String] = ["dr", "legs", "pomgranate", "traffic_lights"];
    public static let ShinImages: [String] = ["chocolate", "garlic", "policeman", "remote", "teeth"];
    public static let TafImages: [String] = ["apple", "baby", "drums", "parrot", "worm"];
    
    
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
