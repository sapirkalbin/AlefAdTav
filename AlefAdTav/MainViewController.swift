//
//  ViewController.swift
//  AlefAdTav
//
//  Created by Sapir Kalbin on 05/07/2019.
//  Copyright © 2019 Sapir Kalbin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var boySelection: UIImageView!
    @IBOutlet weak var girlSelection: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
    
        boySelection.isUserInteractionEnabled = true
        boySelection.addGestureRecognizer(tapGestureRecognizer)
        girlSelection.isUserInteractionEnabled = true
        girlSelection.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        var boyOrGirl = ""
        let tappedImage = tapGestureRecognizer.view as!UIImageView
        if (tappedImage.restorationIdentifier == "boySelection")
        {
            boyOrGirl = "boy"
        }
        else
        {
            boyOrGirl = "girl"
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let subjectViewController = storyBoard.instantiateViewController(withIdentifier: "SubjectViewController") as! SubjectViewController
        subjectViewController.setGender(boyOrGirl: boyOrGirl)

        self.present(subjectViewController, animated: true, completion: nil)
    }

}

