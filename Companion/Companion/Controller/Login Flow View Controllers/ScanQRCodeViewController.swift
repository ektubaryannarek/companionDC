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
    @IBOutlet weak var nextButtonView: UIView!
    @IBOutlet weak var troubleMessageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBarTransparent()
        
        let nextButtonGesture = UITapGestureRecognizer(target: self, action: #selector(nextButtonClicked))
        let troubleMessageGesture = UITapGestureRecognizer(target: self, action: #selector(troubleButtonClicked))

        self.nextButtonView.addGestureRecognizer(nextButtonGesture)
        self.troubleMessageView.addGestureRecognizer(troubleMessageGesture)

    }
    
    func makeNavBarTransparent(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func nextButtonClicked(){
        performSegue(withIdentifier: "toConnectWithMyiaFromScan", sender: nil)
    }
    
    func troubleButtonClicked(){
        performSegue(withIdentifier: "toEnterCode", sender: nil)
    }
}
