//
//  SubjectViewController.swift
//  AlefAdTav
//
//  Created by Sapir Kalbin on 07/07/2019.
//  Copyright © 2019 Sapir Kalbin. All rights reserved.
//

import UIKit

class SubjectViewController: UIViewController {
    @IBOutlet weak var lettersImage: UIImageView!
    @IBOutlet weak var nikudImage: UIImageView!
    var gender = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lettersTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(lettersmageTapped(_:)))
        let nikudTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(nikudImageTapped(_:)))
        
        lettersImage.isUserInteractionEnabled = true
        nikudImage.isUserInteractionEnabled = true

        lettersImage.addGestureRecognizer(lettersTapGestureRecognizer)
        nikudImage.addGestureRecognizer(nikudTapGestureRecognizer)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.landscapeLeft)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
        
    }
    
    @objc func nikudImageTapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        goToListViewController(subject: "nikud")
    }
    
    @objc func lettersmageTapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        goToListViewController(subject: "letters")
    }
    
    private func goToListViewController(subject: String)
    {
        if let allLettersViewController = storyboard?.instantiateViewController(withIdentifier: "AllLettersViewController") as? AllLettersViewController
        {
            allLettersViewController.setSubject(lettersOrNikud: subject)
            self.present(allLettersViewController, animated: true, completion: nil)
        }
    }
    
    func setGender(boyOrGirl: String)
    {
        gender = boyOrGirl
    }
    
    
}
