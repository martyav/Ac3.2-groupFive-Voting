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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(self.official)
        APIRequestManager.manager.getArticles(searchTerm: official.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!) { (info) in
            print(info?.count)
        }

        // Do any additional setup after loading the view.
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
