//
//  MainViewController.swift
//  Companion
//
//  Created by Narek Ektubaryan on 2/12/18.
//  Copyright © 2018 Double Coconut. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var MenuTableContainerView: UIView!
    @IBOutlet weak var MYIAWebContainerView: UIView!
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var menuTableLeadingConstraint: NSLayoutConstraint!
    var hamburgerMenuIsVisible = false
    
    @IBAction func hamburgerBtnTapped(_ sender: Any) {
        if !hamburgerMenuIsVisible {
            dimView.isHidden = true
            menuTableLeadingConstraint.constant = -160
            hamburgerMenuIsVisible = true
        } else {
            menuTableLeadingConstraint.constant = 0
            dimView.isHidden = false
            hamburgerMenuIsVisible = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The animation is complete!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

