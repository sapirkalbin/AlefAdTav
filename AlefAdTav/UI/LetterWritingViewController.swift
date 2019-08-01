//
//  AlefWritingViewController.swift
//  AlefAdTav
//
//  Created by Sapir Kalbin on 23/07/2019.
//  Copyright © 2019 Sapir Kalbin. All rights reserved.
//

import UIKit

class LetterWritingViewController: UIViewController {
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var currentLetter = ""
    @IBOutlet var myView: UIView!
    
    @IBOutlet weak var letterImage: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var nextButton: UIImageView!
    @IBOutlet weak var homeButton: UIImageView!
    @IBOutlet weak var previousButton: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letterImage.image = UIImage(named: AppUtility.currentLetter)
        mainImageView.image = UIImage(named: AppUtility.currentLetter + "-try")
        tempImageView.image = UIImage(named: AppUtility.currentLetter + "-try")

        ButtonsTapsHandler()
        simulateTap()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: view)
        if(location.y > UIScreen.main.bounds.height / 2)
        {
            swiped = false
            lastPoint = location
        }
    }
    
    
    func simulateTap() {
        ////// there is a bug. after clicking on screen image is stretching so we tried simulating tap but it didnt work.
        let pointOnTheScreen = CGPoint(x:100, y:100)
        self.tempImageView.hitTest(pointOnTheScreen, with: nil)
        print("tap on screen")
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        // 1
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        tempImageView.image?.draw(in: view.bounds)
        
        // 2
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        // 3
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)
        
        // 4
        context.strokePath()
        
        // 5
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: view)
        
        if(location.y > UIScreen.main.bounds.height / 2)
        {
            swiped = true
            let currentPoint = location
            drawLine(from: lastPoint, to: currentPoint)
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            // draw a single point
            drawLine(from: lastPoint, to: lastPoint)
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
        tempImageView?.image?.draw(in: view.bounds, blendMode: .normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.landscapeLeft)
    }
    
    func ButtonsTapsHandler() {
        let nextButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(nextTapped(_:)))
        let homeButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(homeTapped(_:)))
        let previousButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(prevTapped(_:)))
        
        
        homeButton.isUserInteractionEnabled = true
        nextButton.isUserInteractionEnabled = true
        previousButton.isUserInteractionEnabled = true
        
        homeButton.addGestureRecognizer(homeButtonTapGestureRecognizer)
        nextButton.addGestureRecognizer(nextButtonTapGestureRecognizer)
        previousButton.addGestureRecognizer(previousButtonTapGestureRecognizer)
        
    }
    
    @objc func homeTapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        goToViewController(viewcontrollerName: "SubjectViewController")
    }
    
    @objc func prevTapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        goToViewController(viewcontrollerName: "LetterIntroViewController")
    }
    
    
    @objc func nextTapped(_ tapGestureRecognizer: UITapGestureRecognizer)
    {
        AppUtility.setProgressLetter(key: AppUtility.currentLetter, progress: 0.666)
        goToViewController(viewcontrollerName: "LetterGameViewController")
    }
    
    private func goToViewController(viewcontrollerName: String)
    {
        if let viewcontroller = storyboard?.instantiateViewController(withIdentifier: viewcontrollerName)
        {
            self.present(viewcontroller, animated: true, completion: nil)
        }
    }
    
}


