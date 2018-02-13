//
//  MYIAWebViewController.swift
//  Companion
//
//  Created by Narek Ektubaryan on 2/12/18.
//  Copyright © 2018 Double Coconut. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class MYIAWebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "http://www.myia.co")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }}
