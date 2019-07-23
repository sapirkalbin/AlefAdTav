//
//  AllLettersViewController.swift
//  AlefAdTav
//
//  Created by Sapir Kalbin on 15/07/2019.
//  Copyright © 2019 Sapir Kalbin. All rights reserved.
//

import UIKit

class AllLettersViewController: UIViewController ,UIGestureRecognizerDelegate
{
//    private let sectionInsets = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 0.0, right: 4.0)
    private let lettersList: [[String]] = [["alef", "beit"], ["gimel", "daled"], ["hey", "vav"],
                                           ["zain", "heit"], ["tet", "yod"], ["kaf", "lamed"], ["mem", "nun"],
                                           ["samech", "ain"], ["pey", "zadi"], ["kuf", "reish"], ["shin", "taf"], ["",""], [""]]
    var lettersOrNikud = ""
    var progressList =  [String : Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getLocalProgressData()
        
    }
    
    func notifyDataSetChanged(collectionView: UICollectionView, indexPathArr: [IndexPath]) {
        collectionView.reloadItems(at: indexPathArr);
    }
    
    func setSubject(lettersOrNikud: String)
    {
        self.lettersOrNikud = lettersOrNikud
    }
    
    func getLocalProgressData()
    {
        let defaults = UserDefaults.standard
        for row in lettersList
        {
            for letter in row
            {
                if let progress: Int = defaults.integer(forKey: letter) {
                    progressList[letter] = progress
                }
            }
        }
    }
}

extension AllLettersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LetterProgressCell", for: indexPath) as! LetterProgressCell
        
        cell.letterImage.image = UIImage(named: lettersList[indexPath.section][indexPath.row])
        
        if let progressLetter = progressList[lettersList[indexPath.section][indexPath.row]] {
            cell.progress.progress = Float(progressLetter)
        }
        
        return cell
    }
    
    // func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    //        let sizeOfBoard = CGFloat(4);
    //        let paddingSpace = sectionInsets.left * (sizeOfBoard + 1);
    //        let availableWidth = collectionView.frame.width - paddingSpace;
    //        let cellWidth = availableWidth / sizeOfBoard;
    //
    //        return CGSize(width: cellWidth, height: cellWidth);
    //  }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        //print("Width: ", collectionView.frame.width, " Height: ", collectionView.frame.height);
//        return sectionInsets;
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInsets.left;
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInsets.left;
//    }
//
    
}


class LetterProgressCell: UICollectionViewCell {
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var letterImage: UIImageView!
    
}
