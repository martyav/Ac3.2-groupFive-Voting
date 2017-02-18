//
//  RepInfo.swift
//  Vote
//
//  Created by C4Q on 2/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class RepInfo {
    var offices: [Office]
    var officials: [GovernmentOfficial]
    
    init(offices: [Office], officials: [GovernmentOfficial]) {
        self.offices = offices
        self.officials = officials
    }
}

class Office {
    let name: String
    let divisionId: String
    let levels: String
    let roles: String
    let index: Int
    
    init(name: String, divisionId: String, levels: String, roles: String, index: Int) {
        self.name = name
        self.divisionId = divisionId
        self.levels = levels
        self.roles = roles
        self.index = index
    }
    
    convenience init?(dict: [String: AnyObject]) {
        guard let name = dict["name"] as? String,
            let divisionId = dict["divisionId"] as? String,
            let levels = dict["levels"] as? [String],
            let roles = dict["roles"] as? [String],
            let index = dict["officialIndices"] as? [Int] else { return nil }
        self.init(name: name, divisionId: divisionId, levels: levels.joined(separator: ", "), roles: roles.joined(separator: ", "), index: index[0])
    }
}

class GovernmentOfficial {
    var name: String
    var address: Address
    var party: String
    var phone: String
    var officeURL: String
    var photoURL: String
    var channels: [Channel]
    
    init(name: String, address: Address, party: String, phone: String, officeURL: String, photoURL: String, channels: [Channel]) {
        self.name = name
        self.address = address
        self.party = party
        self.phone = phone
        self.officeURL = officeURL
        self.photoURL = photoURL
        self.channels = channels
    }
}

class Channel {
    let type: String
    let id: String
    
    init(type: String, id: String) {
        self.type = type
        self.id = id
    }
    
    convenience init?(dict: [String: String]) {
        guard let type = dict["type"],
            let id = dict["id"] else { return nil }
        self.init(type: type, id: id)
    }
}

/*
{
    "name": "Donald J. Trump",
    "address": [
    {
    "line1": "The White House",
    "line2": "1600 Pennsylvania Avenue NW",
    "city": "Washington",
    "state": "DC",
    "zip": "20500"
    }
    ],
    "party": "Republican",
    "phones": [
    "(202) 456-1111"
    ],
    "urls": [
    "http://www.whitehouse.gov/"
    ],
    "photoUrl": "https://www.whitehouse.gov/sites/whitehouse.gov/files/images/45/PE%20Color.jpg",
    "channels": [
    {
    "type": "GooglePlus",
    "id": "+whitehouse"
    },
    {
    "type": "Facebook",
    "id": "whitehouse"
    },
    {
    "type": "Twitter",
    "id": "whitehouse"
    },
    {
    "type": "YouTube",
    "id": "whitehouse"
    }
    ]
},
 */
