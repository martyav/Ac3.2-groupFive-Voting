//
//  InitialViewController.swift
//  Vote
//
//  Created by Simone on 2/21/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class InitialViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var largeContainer: UIView!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var buttonOverlay: UIButton!
    @IBOutlet weak var getStartedLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var index = 0
    var largeText = ""
    var imageName = ""
    var descriptionTxt = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateView()
    }
    
    func populateView() {
        promptLabel.text = largeText.uppercased()
        textView.text = descriptionTxt
        imageView.image = UIImage(named: imageName)
        pageControl.currentPage = index
        buttonOverlay.isHidden = (index == 2) ? false : true
        getStartedLabel.isHidden = (index == 2) ? false : true
        //format
        promptLabel.textColor = UIColor.hackathonCream
        promptLabel.font = UIFont(name: "GillSans-Bold", size: 20)
        textView.textColor = UIColor.hackathonCream
        textView.font = UIFont(name: "GillSans", size: 18)
        getStartedLabel.textColor = UIColor.hackathonCream
        getStartedLabel.font = UIFont(name: "GillSans-Bold", size: 20)
        imageView.layer.cornerRadius = imageView.frame.height/2
//        imageView.autoresizingMask = .flexibleHeight
//        imageView.layer.masksToBounds = true

    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        let userDefault = UserDefaults.standard
        userDefault.set(true, forKey: "walkthrough")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    

    
}
