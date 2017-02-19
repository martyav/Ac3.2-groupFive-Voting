//
//  SearchViewController.swift
//  Vote
//
//  Created by Simone on 2/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

protocol ZipDelegate {
    func getReps(from zip: String)
}

class SearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var zipTextField: UITextField!
    
    var zip = ""
    
    let dvc = RepresentativeTableViewController()
    var delegate: ZipDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zipTextField.delegate = self
        self.delegate = dvc
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let numbers = Set<String>(arrayLiteral: "0", "1", "2", "3", "4", "5", "6", "7", "8", "9")
        guard numbers.contains(string) || string.isEmpty else { return false }
        
        if textField.text!.characters.count + string.characters.count == 5 {
            
            
            self.present(dvc, animated: true, completion: {
                self.delegate.getReps(from: textField.text! + string)
            })
        }
        print(string)
        return true
    }
}
