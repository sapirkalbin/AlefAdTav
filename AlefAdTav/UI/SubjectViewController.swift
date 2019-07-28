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
        //nikudImage.isUserInteractionEnabled = true

        lettersImage.addGestureRecognizer(lettersTapGestureRecognizer)
        nikudImage.addGestureRecognizer(nikudTapGestureRecognizer)
        
    }
    
    @objc func nikudImageTapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        goToViewController(subject: "nikud")
    }
    
    @objc func lettersmageTapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        goToViewController(subject: "letters")
    }
    
    private func goToViewController(subject: String)
    {
        if let allLettersViewController = storyboard?.instantiateViewController(withIdentifier: "AllLettersViewController") as? AllLettersViewController
        {
            self.present(allLettersViewController, animated: true, completion: nil)
        }
    }
    
    
    
}
