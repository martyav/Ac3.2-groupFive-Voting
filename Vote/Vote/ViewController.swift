//
//  ViewController.swift
//  Vote
//
//  Created by C4Q on 2/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APIRequestManager.manager.getElections { (election) in
            dump(election)
        }
        APIRequestManager.manager.getVoterInfo(endPoint: "https://www.googleapis.com/civicinfo/v2/voterinfo?key=AIzaSyBU0xkqxzxgDJfcSabEFYMXD9M-i8ugdGo&address=301%20Virginia%20St%20UNIT%20809,%20Richmond,%20VA%2023219&electionId=4269") { (info) in
            dump(info)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

