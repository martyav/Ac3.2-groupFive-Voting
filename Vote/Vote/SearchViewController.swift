//
//  SearchViewController.swift
//  Vote
//
//  Created by Simone on 2/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import AudioToolbox

let context = 0


class SearchViewController: UIViewController, UITextFieldDelegate, ZipAlertDelegate {
    
    @IBOutlet weak var zipTextField: UITextField!
    
    var time = 0.0
    var timer: Timer!
    var presentAlert: Bool = false
    
    var phoneView: UIImageView?
    var buildingView: UIImageView?
    var blueBubbleViewLeft: UIImageView?
    var blueBubbleViewRight: UIImageView?
    var redBubbleViewLeft: UIImageView?
    var redBubbleViewRight: UIImageView?
    
    var propertyAnimator: UIViewPropertyAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zipTextField.delegate = self
        
        title = "Find Your Rep"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(checkTextFieldContent(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: zipTextField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.time = 0.0
        
        if !zipTextField.text!.isEmpty {
            zipTextField.text = ""
        }
        
        if presentAlert {
            showAlert("Invalid Zipcode", presentOn: self)
            self.presentAlert = false
        }
        
        createAndConstrainImages()
        
        _ = [
            blueBubbleViewLeft,
            redBubbleViewLeft,
            redBubbleViewRight,
            blueBubbleViewRight
            //phoneView
            ].map { $0?.alpha = 0 }
        
        phoneView?.transform = CGAffineTransform(rotationAngle: (3 * CGFloat.pi)/4)
        
        propertyAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: nil)
        
        UIView.animate(withDuration: 2, animations: {
                self.phoneView?.transform = CGAffineTransform(translationX: 0, y: -10)
                self.phoneView?.transform = CGAffineTransform.identity
        })
        
        self.phoneView?.transform = CGAffineTransform(translationX: 0, y: 5)
        
        //UIView.animate(withDuration: .infinity, delay: 0.7, options: .repeat, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
        
        //self.animatePhone()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let numbers = Set<String>(arrayLiteral: "0", "1", "2", "3", "4", "5", "6", "7", "8", "9")
        guard (numbers.contains(string) || string.isEmpty), textField.text!.characters.count < 5 else  { return false }
        
        return true
    }
    
    func checkTextFieldContent (_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if textField.text!.characters.count == 5 {
                self.timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(checkTime), userInfo: nil, repeats: true)
                
                timer.fire()
            }
        }
    }
    
    func checkTime () {
        if self.time == 1  {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let dvc = storyboard.instantiateViewController(withIdentifier: "rtvc") as! RepresentativeTableViewController
            dvc.getReps(from: self.zipTextField.text!)
            dvc.delegate = self
            self.navigationController?.pushViewController(dvc, animated: true)
            timer.invalidate()
        }
        
        self.time += 1
    }
    
    // MARK: - Noise
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        AudioServicesPlaySystemSound(1105)
    }
    
    // Animation stuff
    
    func createAndConstrainImages() {
        self.buildingView = UIImageView(frame: .zero)
        self.phoneView = UIImageView(frame: .zero)
        self.blueBubbleViewRight = UIImageView(frame: .zero)
        self.blueBubbleViewLeft = UIImageView(frame: .zero)
        self.redBubbleViewRight = UIImageView(frame: .zero)
        self.redBubbleViewLeft = UIImageView(frame: .zero)
        
        self.buildingView?.image = #imageLiteral(resourceName: "blueBuilding")
        self.phoneView?.image = #imageLiteral(resourceName: "redPhone")
        self.blueBubbleViewRight?.image = #imageLiteral(resourceName: "blueBubble")
        self.blueBubbleViewLeft?.image = #imageLiteral(resourceName: "blueBubble")
        self.redBubbleViewRight?.image = #imageLiteral(resourceName: "redBubble")
        self.redBubbleViewLeft?.image = #imageLiteral(resourceName: "redBubble")
        
        self.view.addSubview(buildingView!)
        self.view.addSubview(phoneView!)
        self.view.addSubview(blueBubbleViewRight!)
        self.view.addSubview(blueBubbleViewLeft!)
        self.view.addSubview(redBubbleViewRight!)
        self.view.addSubview(redBubbleViewLeft!)
        
        self.view.bringSubview(toFront: buildingView!)
        self.view.bringSubview(toFront: phoneView!)
        self.view.bringSubview(toFront: blueBubbleViewLeft!)
        self.view.bringSubview(toFront: redBubbleViewLeft!)
        self.view.bringSubview(toFront: blueBubbleViewRight!)
        self.view.bringSubview(toFront: redBubbleViewRight!)
        
        self.buildingView?.snp.makeConstraints{ (view) in
            view.centerX.equalToSuperview()
            view.bottom.equalTo(zipTextField.snp.top).offset(-10)
        }
        
        self.phoneView?.snp.makeConstraints{ (view) in
            view.centerY.equalTo((buildingView?.snp.centerY)!)
            view.centerX.equalTo((buildingView?.snp.centerX)!)
        }
        
        self.blueBubbleViewRight?.snp.makeConstraints{ (view) in
            view.centerY.equalTo((buildingView?.snp.centerY)!)
            view.leading.equalTo((buildingView?.snp.trailing)!).inset(9)
        }
        
        self.blueBubbleViewLeft?.snp.makeConstraints{ (view) in
            view.centerY.equalTo((buildingView?.snp.centerY)!).inset(-15)
            view.trailing.equalTo((buildingView?.snp.leading)!)
        }
        
        self.redBubbleViewRight?.snp.makeConstraints{ (view) in
            view.centerY.equalTo((buildingView?.snp.centerY)!).inset(-25)
            view.leading.equalTo((buildingView?.snp.trailing)!).offset(-10)
        }
        
        self.redBubbleViewLeft?.snp.makeConstraints{ (view) in
            view.centerY.equalTo((buildingView?.snp.centerY)!)
            view.trailing.equalTo((buildingView?.snp.leading)!).offset(9)
        }
        
        redBubbleViewLeft?.transform = CGAffineTransform(scaleX: -1, y: 1)
        blueBubbleViewLeft?.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
//    func animatePhone() {
//        propertyAnimator?.addAnimations {
//            self.view.layoutIfNeeded()
//            self.buildingView?.transform = CGAffineTransform.identity
//            self.phoneView?.transform = CGAffineTransform.identity
//        }
//        
//        propertyAnimator?.startAnimation()
//    }
}

