//
//  RepDetailsViewController.swift
//  Vote
//
//  Created by Simone on 2/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class RepDetailsViewController: UIViewController {
    
    var official: GovernmentOfficial!
    var office: Office!

    @IBOutlet weak var repImageView: UIImageView!
    @IBOutlet weak var repNameLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var officeLevel: UILabel!
    @IBOutlet weak var briefJobDescription: UITextView!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputViewValues()
        APIRequestManager.manager.getArticles(searchTerm: official.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!) { (info) in
            print(info?.count)
        }
    }
    
    func inputViewValues () {
        self.repNameLabel.text = official.name
        self.officeLevel.text = office.name
        print(office.name)
        self.districtLabel.text = office.divisionId
        self.officeLevel.text = office.levels
//        self.briefJobDescription.text =
        self.contactLabel.text = "\(official.name)'s Contact Information"
        self.phoneNumberLabel.text = official.phone
        self.emailLabel.text = official.email
        
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
