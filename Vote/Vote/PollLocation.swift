//
//  PollLocation.swift
//  Vote
//
//  Created by C4Q on 2/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation


class PollLocation {
    var address: String
    var notes: String
    var hours: String
    
    init(address: String, notes: String, hours: String) {
        self.address = address
        self.notes = notes
        self.hours = hours
    }
    
    convenience init?(dict: [String: AnyObject]) {
        guard let addressDict = dict["address"] as? [String: String],
        let notes = dict["notes"] as? String,
        let 
    }
}

/*
 {
      "address": {
        "locationName": "MAIN LIBRARY",
        "line1": "101 East Franklin Street",
        "city": "Richmond",
        "state": "VA",
        "zip": "23219-2107"
      },
      "notes": "",
      "pollingHours": "6:00 AM - 7:00 PM",
      "sources": [
        {
          "name": "Voting Information Project",
          "official": true
        }
      ]
    }
 */
