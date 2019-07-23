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
        
        let boyTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(boyImageTapped(_:)))
        let girlTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(girlImageTapped(_:)))

        
        boySelection.isUserInteractionEnabled = true
        girlSelection.isUserInteractionEnabled = true

        boySelection.addGestureRecognizer(boyTapGestureRecognizer)
        girlSelection.addGestureRecognizer(girlTapGestureRecognizer)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.landscapeLeft)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
        
    }
    
    @objc func girlImageTapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        goToTypeViewController(gender: "girl")
    }
    
    @objc func boyImageTapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
       goToTypeViewController(gender: "boy")
    }
    
    private func goToTypeViewController(gender: String)
    {
        if let subjectViewController = storyboard?.instantiateViewController(withIdentifier: "SubjectViewController") as? SubjectViewController
        {
            subjectViewController.setGender(boyOrGirl: gender)
            self.present(subjectViewController, animated: true, completion: nil)
        }
    }
}

