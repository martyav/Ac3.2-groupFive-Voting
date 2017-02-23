//
//  RepresentativeTableViewController.swift
//  Vote
//
//  Created by Simone on 2/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import AudioToolbox
import CoreLocation

protocol ZipAlertDelegate {
    var presentAlert: Bool { get set }
}

class RepresentativeTableViewController: UITableViewController {
    
    let cellID = "repCell"
    var representatives = [RepInfo]()
    var office = [Office]()
    var repDetails = [GovernmentOfficial]()
    var delegate: ZipAlertDelegate!
    let storyboardFile = UIStoryboard.init(name: "Main", bundle: nil)
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "List of Reps"
        
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: nil, action: nil)
        self.navigationItem.hidesBackButton = true
        self.edgesForExtendedLayout = .bottom
        self.tableView.register(RepresentativesTableViewCell.self, forCellReuseIdentifier: cellID)
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.preservesSuperviewLayoutMargins = false
        self.tableView.separatorInset = UIEdgeInsets.zero
        self.tableView.layoutMargins = UIEdgeInsets.zero
        setupNavigationButton()
    }
    
    func getLocationName(from zip: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(zip) { (placemark, error) in

                
            
            
        }
    }
    
    func getReps(from zip: String) {
        APIRequestManager.manager.getRepInfo(endPoint: "https://www.googleapis.com/civicinfo/v2/representatives?key=AIzaSyBU0xkqxzxgDJfcSabEFYMXD9M-i8ugdGo&address=\(zip)") { (info) in
            if let validInfo = info {
                self.office = validInfo.offices.reversed()
                self.repDetails = validInfo.officials
                self.defaults.set(zip, forKey: "zipcode")
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.delegate.presentAlert = true
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
        }
        getLocationName(from: zip)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return office.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return office[section].indices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RepresentativesTableViewCell
        let officialIndex = office[indexPath.section].indices[indexPath.row]
        print(officialIndex)
        print()
        let official = self.repDetails[officialIndex]
        
        cell.official = official
        
        cell.backgroundColor = UIColor.hackathonCream
        cell.nameLabel.font = UIFont(name: "GillSans-SemiBold", size: 16)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return office[section].name
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath) as! RepresentativesTableViewCell
        let dvc = storyboardFile.instantiateViewController(withIdentifier: "rdvc") as! RepDetailsViewController
        dvc.official = currentCell.official
        dvc.office = self.office[indexPath.section]
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.hackathonCream
        header.textLabel?.lineBreakMode = .byWordWrapping
        header.textLabel?.numberOfLines = 2
        header.textLabel?.textAlignment = .center
        header.textLabel?.adjustsFontForContentSizeCategory = true
    }
    
    // MARK: - Noise
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParentViewController){
            AudioServicesPlaySystemSound(1105)
        }
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        AudioServicesPlaySystemSound(1105)
    }
    
    func setupNavigationButton () {
        
        let image = UIImage(named: "search")
        let searchButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(searchButtonPressed))
        searchButton.tintColor = UIColor.hackathonCream
        searchButton.imageInsets = UIEdgeInsetsMake(1, 1, 1, 1)
        self.navigationItem.leftBarButtonItem = searchButton
    }
    
    func searchButtonPressed () {
        self.defaults.set("", forKey: "zipcode")
        if navigationController?.viewControllers[0] === self {
            let dvc = storyboardFile.instantiateViewController(withIdentifier: "searchVC") as! RepDetailsViewController

            
            navigationController?.pushViewController(dvc, animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
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
