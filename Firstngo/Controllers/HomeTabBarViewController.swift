//
//  HomeTabBarViewController.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 2/24/20.
//  Copyright © 2020 Artash Ghazaryan. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13, *) {
            let appearance = self.tabBar.standardAppearance.copy()
            appearance.backgroundImage = UIImage()
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .clear
            self.tabBar.standardAppearance = appearance
        } else {
            self.tabBar.backgroundImage = UIImage()
            self.tabBar.shadowImage = UIImage()
        }
        
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
        // Do any additional setup after loading the view.
    }

}
