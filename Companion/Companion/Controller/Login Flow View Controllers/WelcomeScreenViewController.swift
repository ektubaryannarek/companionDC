//
//  WelcomeScreenViewController.swift
//  Companion
//
//  Created by Narek Ektubaryan on 2/14/18.
//  Copyright © 2018 Double Coconut. All rights reserved.
//

import Foundation
import UIKit

class WelcomeScreenViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nextButtonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBarTransparent()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(nextButtonClicked))
        self.nextButtonView.addGestureRecognizer(gesture)
    }

    private func makeNavBarTransparent(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func nextButtonClicked(){
        performSegue(withIdentifier: "toDisplayQR", sender: nil)
    }
    
}
