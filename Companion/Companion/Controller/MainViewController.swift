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
    
    let animationDuration = 0.2
    var hamburgerMenuIsVisible = false
    
    @IBAction func hamburgerBtnTapped(_ sender: Any) {
        if !hamburgerMenuIsVisible {
            hideHamburgerMenu()
        } else {
            showHamburgerMenu()
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(MainViewController.hideHamburgerMenu))
        self.dimView.addGestureRecognizer(gesture)
    }
    
    func hideHamburgerMenu(){
        dimView.isHidden = true
        menuTableLeadingConstraint.constant = -160
        hamburgerMenuIsVisible = true
        animateTransition()
    }
    
    func showHamburgerMenu(){
        menuTableLeadingConstraint.constant = 0
        dimView.isHidden = false
        hamburgerMenuIsVisible = false
        animateTransition()
    }
    
    func animateTransition () {
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in

        }
    }
}

