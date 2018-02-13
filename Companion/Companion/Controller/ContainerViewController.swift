//
//  ViewController.swift
//  Companion
//
//  Created by Narek Ektubaryan on 12/02/18.
//  Copyright © 2018 Double Coconut. All rights reserved.
//

import UIKit
import WebKit

class ContainerViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    var sideMenuOpen = false

    
    @IBOutlet weak var sideMenuContainerView: UIView!
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    @IBAction func hamburgerBtnTapped(_ sender: Any) {
        
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleSideMenu),
                                               name: NSNotification.Name("ToggleSideMenu"),
                                               object: nil)
        
        let myURL = URL(string: "https://www.myia.co")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    @objc func toggleSideMenu() {
        if sideMenuOpen {
            sideMenuOpen = false
            sideMenuConstraint.constant = -240
            
        } else {
            sideMenuOpen = true
            sideMenuConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

