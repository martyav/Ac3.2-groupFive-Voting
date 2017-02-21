//
//  Introductions.swift
//  Vote
//
//  Created by Simone on 2/19/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class Introduction: UIPageViewController, UIPageViewControllerDataSource {
    
    var prompts = ["Welcome To Call", "How To Connect", "Maximize Your Voice"]
    var pageImages = ["buildingPhone", "redPhone", "defaultParty"]
    var textDescriptions = ["Are you curious about who your local representatives are? Would you like an easy way to voice your concerns? Use Call to connect with your local representatives effortlessly.", "Using the search field, enter your zip code and select the representative you would like to contact.", "With an easy tap, you can either telephone or email your representative directly from Call.  A green icon means your free to connect."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        navigationItem.hidesBackButton = true

        if let startIntro = self.viewControllerAtIndex(0) {
            setViewControllers([startIntro], direction: .forward, animated: true, completion: nil)
        }
    }
    
    //MARK: - Page Index
    func indexAtNextPage(_ index: Int) {
        if let nextVC = self.viewControllerAtIndex(index+1) {
            setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func viewControllerAtIndex(_ index: Int) -> InitialViewController? {
        
        if index == NSNotFound || index < 0 || index >= self.textDescriptions.count {
            return nil
        }
        
        if let wvc = storyboard?.instantiateViewController(withIdentifier: "walkthrough") as?
            InitialViewController {
            wvc.imageName = pageImages[index]
            wvc.largeText = prompts[index]
            wvc.descriptionTxt = textDescriptions[index]
            wvc.index = index
            return wvc
        }
        return nil
        
    }
    
    //MARK: - PageViewController
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! InitialViewController).index
        index -= 1
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! InitialViewController).index
        index += 1
        
        return self.viewControllerAtIndex(index)
    }
    

    
}


//Are you curious about who your local representatives are? Would you like an easy way to voice your concerns? Welcome to Call.

//Using the search field, enter your zip code and select the representative you would like to contact.

//With an easy tap, you can either telephone or email your representative directly from Call. A green icon means yours calls are ready to be made. <Get started>


