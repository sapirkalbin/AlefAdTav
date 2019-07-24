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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let cellID: String = "letterCellID"
//    private let sectionInsets = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 0.0, right: 4.0)
    private let lettersList: [[String]] = [["alef", "beit", "gimel", "daled"], ["hey", "vav","zain", "heit"], ["tet", "yod","kaf", "lamed"], ["mem", "nun",
                                "samech", "ain"], ["pey", "zadi","kuf", "reish"], ["shin", "taf"]]
    var lettersOrNikud = ""
    var progressList =  [String : Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        collectionView.register(UINib(nibName: "LetterProgressCell", bundle: nil), forCellWithReuseIdentifier: AllLettersViewController.cellID)
        getLocalProgressData()
        createCollectionViewLayout()
        
    }
    
    private func createCollectionViewLayout()
    {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        collectionView.collectionViewLayout = layout
        
        collectionView.reloadData()
    }
    
//    func notifyDataSetChanged(collectionView: UICollectionView, indexPathArr: [IndexPath]) {
//        collectionView.reloadItems(at: indexPathArr);
//    }
    
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
                else{
                    progressList[letter] = 0
                }
            }
        }
    }
}

extension AllLettersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  lettersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lettersList[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 4, height: view.frame.height / 3)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllLettersViewController.cellID, for: indexPath) as? LetterProgressCell
        {
            let name = lettersList[indexPath.section][indexPath.row]
            
            cell.letterImage.image = UIImage(named: lettersList[indexPath.section][indexPath.row])
            cell.backgroundColor = UIColor.red
            
            if let progressLetter = progressList[lettersList[indexPath.section][indexPath.row]] {
                cell.progress.progress = Float(progressLetter)
            }
            
            return cell
        }
        
        return UICollectionViewCell()
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