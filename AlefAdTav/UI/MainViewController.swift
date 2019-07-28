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
        
        onTapSelectGender()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.landscapeLeft)
    }
    
    
    func onTapSelectGender() {
        let boyTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(boyImageTapped(_:)))
        let girlTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(girlImageTapped(_:)))
        
        
        boySelection.isUserInteractionEnabled = true
        girlSelection.isUserInteractionEnabled = true
        
        boySelection.addGestureRecognizer(boyTapGestureRecognizer)
        girlSelection.addGestureRecognizer(girlTapGestureRecognizer)
    }
    
    @objc func girlImageTapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        AppUtility.gender = "girl"
        goToTypeViewController()
    }
    
    @objc func boyImageTapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        AppUtility.gender = "boy"
       goToTypeViewController()
    }
    
    private func goToTypeViewController()
    {
        if let subjectViewController = storyboard?.instantiateViewController(withIdentifier: "SubjectViewController")
        {
            self.present(subjectViewController, animated: true, completion: nil)
        }
    }
}

