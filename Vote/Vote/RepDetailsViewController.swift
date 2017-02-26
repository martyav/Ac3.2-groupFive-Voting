//
//  RepDetailsViewController.swift
//  Vote
//
//  Created by Simone on 2/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import MessageUI
import AudioToolbox

class RepDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var repImageView: UIImageView!
    @IBOutlet weak var repNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var briefJobDescription: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBOutlet weak var stripeView: UIView!
    @IBOutlet weak var bottomGradient: UIView!
    
    var official: GovernmentOfficial!
    var office: Office!
    var articles = [Article]()
    
    var time = 0.0
    var timer: Timer!
    var selection: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        //self.navigationItem.hidesBackButton = true
        
        inputViewValues()
        
        APIRequestManager.manager.getArticles(searchTerm: official.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!) { (info) in
            if let info = info {
                self.articles = info
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                    if self.activityIndicator.isAnimating {
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
        
        
        title = official.name
        
        collectionView.register(HeadlinesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        print(articles)
        
        //self.view.addSubview(newsCollectionLabel)
        
        //        newsCollectionLabel.snp.makeConstraints { (view) in
        //            view.bottom.equalTo(collectionView.snp.top)
        //            view.leading.equalTo(collectionView)
        //        }
        
        //        newsCollectionLabel.textColor = UIColor.hackathonCream
        //        newsCollectionLabel.font = UIFont(name: "GillSans-Bold", size: 16)
        instructionLabel.text = "Click to contact \(official.name)!"
        instructionLabel.textColor = UIColor.hackathonCream
        instructionLabel.font = UIFont(name: "GillSans-Italic", size: 16)
        
        configureConstraintsForContainerView()
    }
    
    override func viewDidLayoutSubviews() {
        self.repImageView.clipsToBounds = true
        self.repImageView.contentMode = .scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.time = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.stripeView.backgroundColor = UIColor.hackathonBlue
        self.repImageView.backgroundColor = UIColor.hackathonBlue
        self.bottomGradient.apply(gradient: [UIColor.hackathonRed, UIColor.hackathonRed, UIColor.hackathonCream])
        
        self.activityIndicator.startAnimating()
        
        if collectionView.visibleCells != [] {
            for cell in collectionView.visibleCells {
                cell.transform = CGAffineTransform.identity
                
                if self.activityIndicator.isAnimating {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    func inputViewValues () {
        self.repImageView.image = UIImage(named: "placeholderPic")
        
        self.emailButton.clipsToBounds = true
        self.phoneNumberButton.clipsToBounds = true
        self.emailButton.layer.borderWidth = 2
        self.emailButton.layer.borderColor = UIColor.lightGray.cgColor
        self.emailButton.apply(gradient: [UIColor.gray.withAlphaComponent(0.01), UIColor.hackathonCream])
        self.phoneNumberButton.apply(gradient: [UIColor.gray.withAlphaComponent(0.01), UIColor.hackathonCream])
        self.phoneNumberButton.layer.borderColor = UIColor.lightGray.cgColor
        self.phoneNumberButton.layer.borderWidth = 2
        
        if let phone = official.phone {
            self.phoneNumberButton.setTitle("\(phone)", for: .normal)
            //self.phoneIconImageView.image = #imageLiteral(resourceName: "greenPhone")
            self.phoneNumberButton.layer.borderColor = UIColor.hackathonBlue.cgColor
        }
        
        if let email = official.email {
            self.emailButton.setTitle("\(email)", for: .normal)
            //self.emailIconImageView.image = #imageLiteral(resourceName: "greenEmail")
            self.emailButton.layer.borderColor = UIColor.hackathonBlue.cgColor
        }
        
        if let photoURL = official.photoURL {
            APIRequestManager.manager.getImage(APIEndpoint: photoURL) { (data) in
                if let validData = data,
                    let validImage = UIImage(data: validData) {
                    DispatchQueue.main.async {
                        self.repImageView.image = validImage
                    }
                }
            }
        }
        
        self.iconImageView = {
            let imageView = UIImageView()
            self.iconImageView.contentMode = .center
            
            switch self.official.party {
            case _ where self.official.party.contains("Democrat"):
                self.iconImageView?.image = #imageLiteral(resourceName: "democrat")
            case "Republican":
                self.iconImageView?.image = #imageLiteral(resourceName: "republican")
            default:
                self.iconImageView?.image = #imageLiteral(resourceName: "defaultParty")
            }
            
            imageView.backgroundColor = UIColor.hackathonWhite
            self.iconImageView?.layer.cornerRadius = 20
            self.iconImageView?.backgroundColor = UIColor.hackathonCream
            self.iconImageView?.layer.borderColor = UIColor.hackathonGrey.cgColor
            self.iconImageView.layer.borderWidth = 0.75
            self.scrollView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "star"))
            self.scrollView.layer.borderColor = UIColor.hackathonCream.cgColor
            self.scrollView.layer.borderWidth = 5
            self.emailButton.layer.cornerRadius = 15
            self.phoneNumberButton.layer.cornerRadius = 15
            
            return imageView
        }()
        
    }
    
    //    var newsCollectionLabel: UIOutlinedLabel! = {
    //        let label = UIOutlinedLabel()
    //        label.text = "In the news..."
    //        return label
    //    }()
    
    //MARK: - Collection View Data Source Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HeadlinesCollectionViewCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.hackathonRed.withAlphaComponent(0.85)
        } else {
            cell.backgroundColor = UIColor.hackathonBlue.withAlphaComponent(0.85)
        }
        
        cell.article = articles[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AudioServicesPlaySystemSound(1105)
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let wvc = storyboard.instantiateViewController(withIdentifier: "wvc") as! WebViewController
        self.selection = articles[indexPath.row].webURL
        wvc.address = selection!
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkTime), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    
    func checkTime () {
        if self.time >= 0.5  {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let wvc = storyboard.instantiateViewController(withIdentifier: "wvc") as! WebViewController
            wvc.address = self.selection!
            print(selection)
            navigationController?.pushViewController(wvc, animated: true)
            timer.invalidate()
        }
        
        self.time += 1
    }
    
    
    //MARK: - Helper Functions
    
    func callNumber(_ weirdPhoneNumber: String) {
        let numbers = Set<Character>(arrayLiteral: "0", "1", "2", "3", "4", "5", "6", "7", "8", "9")
        let validPhoneNumber = weirdPhoneNumber.characters.filter { numbers.contains($0) }
        let phoneNumber = String(validPhoneNumber)
        print(phoneNumber)
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func emailPerson() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
    }
    
    
    //MARK: - Actions
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([self.official.email!])
        mailComposerVC.setSubject("Letter from a Constituent")
        mailComposerVC.setMessageBody("\(official.name), \n\n ", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        showAlert("A contact email for \(self.official.name) isn't available.", presentOn: self)
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func phoneButtonPressed(_ sender: UIButton) {
        AudioServicesPlaySystemSound(1105)
        if let number = self.official.phone {
            self.callNumber(number)
        } else {
            showAlert("Sorry! We don't have a valid phone number for \(self.official.name)!", presentOn: self)
        }
    }
    
    @IBAction func emailButtonPressed(_ sender: UIButton) {
        AudioServicesPlaySystemSound(1105)
        if let _ = self.official.email {
            self.emailPerson()
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    // MARK: - Noise & Animations
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        AudioServicesPlaySystemSound(1105)
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        AudioServicesPlaySystemSound(1105)
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.transform = CGAffineTransform.identity
    }
    
    //MARK: - Layout Shadows
    
    let phoneButtonContainerView: UIView = {
        let containerView = UIView()
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        containerView.layer.shadowRadius = 5
        containerView.layer.cornerRadius = 15
        return containerView
    }()
    
    let emailButtonContainerView: UIView = {
        let containerView = UIView()
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        containerView.layer.shadowRadius = 5
        containerView.layer.cornerRadius = 15
        return containerView
    }()
    
    func configureConstraintsForContainerView() {
        self.phoneView.addSubview(phoneButtonContainerView)
        self.emailView.addSubview(emailButtonContainerView)
        
        phoneNumberButton.snp.removeConstraints()
        emailButton.snp.removeConstraints()
        
        phoneButtonContainerView.snp.makeConstraints { (view) in
            view.height.equalTo(65)
            view.width.equalTo(200)
            view.centerY.centerX.equalToSuperview()
        }
        
        emailButtonContainerView.snp.makeConstraints { (view) in
            view.height.equalTo(65)
            view.width.equalTo(200)
            view.centerY.centerX.equalToSuperview()
        }
        
        phoneButtonContainerView.addSubview(phoneNumberButton)
        emailButtonContainerView.addSubview(emailButton)
        
        phoneNumberButton.snp.remakeConstraints { (view) in
            view.top.trailing.bottom.leading.equalToSuperview()
        }
        
        emailButton.snp.remakeConstraints { (view) in
            view.top.trailing.bottom.leading.equalToSuperview()
        }
        
        
    }
    
}
