//
//  MenuTableViewController.swift
//  Companion
//
//  Created by Narek Ektubaryan on 2/12/18.
//  Copyright © 2018 Double Coconut. All rights reserved.
//

import Foundation
import UIKit


class MenuTableViewController: UITableViewController {
    
    let menuAttributItems = ["Sensors","Share","Location","Settings","Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuAttributItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuAttributesCell", for: indexPath)
        
        cell.textLabel?.text = menuAttributItems[indexPath.row]
        
        let imageName = UIImage(named: menuAttributItems[indexPath.row])
        cell.imageView?.image = imageName
        
        let seperatorImageView = UIImageView.init(image: UIImage.init(named: "separatorimg.png"))
        seperatorImageView.frame = CGRect(x: 0, y: cell.contentView.frame.size.height - 2.0,  width: cell.contentView.frame.size.width, height: 2)
        cell.contentView.addSubview(seperatorImageView)
        
        return cell
    }
    
}


