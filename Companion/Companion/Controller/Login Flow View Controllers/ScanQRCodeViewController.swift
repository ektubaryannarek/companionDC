//
//  ScanQRCodeViewController.swift
//  Companion
//
//  Created by Narek Ektubaryan on 2/14/18.
//  Copyright © 2018 Double Coconut. All rights reserved.
//

import Foundation
import UIKit

class ScanQRCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBarTransparent()
    }
    
    func makeNavBarTransparent(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
}
