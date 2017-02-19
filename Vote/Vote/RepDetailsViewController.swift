//
//  RepDetailsViewController.swift
//  Vote
//
//  Created by Simone on 2/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class RepDetailsViewController: UIViewController {
    
    @IBOutlet weak var repImageView: UIImageView!
    @IBOutlet weak var repNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var briefJobDescription: UITextView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!

    var official: GovernmentOfficial!
    var office: Office!
    var articles = [Article]()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       print(official.photoURL)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        inputViewValues()
        APIRequestManager.manager.getArticles(searchTerm: official.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!) { (info) in
//            print(info?.count)
        
            if let info = info {
                self.articles = info
                DispatchQueue.main.async {
                     self.collectionView?.reloadData()
                }
            }
        }

        title = self.repNameLabel.text
        
        collectionView.register(HeadlinesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        print(articles)

    }
    
    override func viewDidLayoutSubviews() {
        self.repImageView.layer.cornerRadius = 60
        self.repImageView.clipsToBounds = true

    }
    
    func inputViewValues () {
        self.repNameLabel.text = official.name
        self.phoneNumberLabel.text = official.phone
        self.emailLabel.text = official.email

        
        APIRequestManager.manager.getImage(APIEndpoint: official.photoURL!) { (data) in
            if let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    self.repImageView.image = validImage
                }
            }
        }
        
       
//        self.iconImageView = {
//            let imageView = UIImageView()
//            switch self.official.party {
//            case _ where self.official.party.contains("Democrat"):
//                self.iconImageView.image = #imageLiteral(resourceName: "democrat")
//            case "Republican":
//                self.iconImageView.image = #imageLiteral(resourceName: "republican")
//            default:
//                self.iconImageView.image = #imageLiteral(resourceName: "defaultParty")
//            }
//            imageView.contentMode = .center
//            imageView.backgroundColor = UIColor.hackathonWhite
//            imageView.layer.cornerRadius = 20
//            imageView.layer.borderColor = UIColor.hackathonBlue.cgColor
//            imageView.layer.borderWidth = 0.75
//            return imageView
//        }()
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

extension RepDetailsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HeadlinesCollectionViewCell
        
        return cell
    }
}
