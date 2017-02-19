//
//  SplashAnimationViewController.swift
//  Vote
//
//  Created by Marty Avedon on 2/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class SplashAnimationViewController: UIViewController {
    
    var phoneView: UIImageView?
    var buildingView: UIImageView?
    var blueBubbleView: UIImageView?
    var redBubbleView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Animations
        
        // create this stuff & constrain it
        
        self.buildingView = UIImageView(frame: .zero)
        self.phoneView = UIImageView(frame: .zero)
        self.blueBubbleView = UIImageView(frame: .zero)
        self.redBubbleView = UIImageView(frame: .zero)
        
        self.buildingView?.image = #imageLiteral(resourceName: "blueBuilding")
        self.phoneView?.image = #imageLiteral(resourceName: "redPhone")
        self.blueBubbleView?.image = #imageLiteral(resourceName: "blueBubble")
        self.redBubbleView?.image = #imageLiteral(resourceName: "redBubble")
        
        self.view.addSubview(buildingView!)
        self.view.addSubview(phoneView!)
        self.view.addSubview(blueBubbleView!)
        self.view.addSubview(redBubbleView!)
        
        self.view.bringSubview(toFront: buildingView!)
        self.view.bringSubview(toFront: phoneView!)
        self.view.bringSubview(toFront: blueBubbleView!)
        self.view.bringSubview(toFront: redBubbleView!)
        
        self.buildingView?.snp.makeConstraints{ (view) in
            view.centerY.equalToSuperview()
            view.centerX.equalToSuperview()
        }
        
        self.phoneView?.snp.makeConstraints{ (view) in
            view.centerY.equalTo((buildingView?.snp.centerY)!)
            view.centerX.equalTo((buildingView?.snp.centerX)!)
        }
        
        self.blueBubbleView?.snp.makeConstraints{ (view) in
            view.centerY.equalTo((buildingView?.snp.centerY)!)
            view.leading.equalTo((buildingView?.snp.trailing)!)
        }
        
        self.redBubbleView?.snp.makeConstraints{ (view) in
            view.centerY.equalTo((buildingView?.snp.centerY)!).inset(100)
            view.leading.equalTo((buildingView?.snp.trailing)!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
