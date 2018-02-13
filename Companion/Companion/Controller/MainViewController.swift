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
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showSession),
                                               name: NSNotification.Name("Sensors"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showSettings),
                                               name: NSNotification.Name("Settings"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showLocation),
                                               name: NSNotification.Name("Location"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showLogout),
                                               name: NSNotification.Name("Logout"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showShare),
                                               name: NSNotification.Name("Share"),
                                               object: nil)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(MainViewController.hideHamburgerMenu))
        self.dimView.addGestureRecognizer(gesture)
    }
    
    @objc func showSession() {
        performSegue(withIdentifier: "sensorsSegue", sender: nil)
    }
    
    @objc func showShare() {
        performSegue(withIdentifier: "shareSegue", sender: nil)
    }
    
    @objc func showLogout() {
        performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
    
    @objc func showSettings() {
        performSegue(withIdentifier: "settingsSegue", sender: nil)
    }
    
    @objc func showLocation() {
        performSegue(withIdentifier: "locationSegue", sender: nil)
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

