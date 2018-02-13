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
    
    enum MenuAttributItem: String {
        case Sensors
        case Share
        case Location
        case Settings
        case Logout
    }
    
    let menuAttributItems = ["Sensors","Share","Location","Settings","Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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
        
        let seperatorImageView = UIImageView.init(image: UIImage.init(named: "Separator.png"))
        seperatorImageView.frame = CGRect(x: 0, y: cell.contentView.frame.size.height - 2.0,  width: cell.contentView.frame.size.width, height: 2)
        cell.contentView.addSubview(seperatorImageView)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let selectedItem = menuAttributItems[indexPath.row]
        let selectedMenuItem: MenuAttributItem = MenuAttributItem (rawValue: selectedItem)!
        
        switch selectedMenuItem{
            case .Sensors  : NotificationCenter.default.post(name: NSNotification.Name("Sensors"), object: nil)
            case .Share    : NotificationCenter.default.post(name: NSNotification.Name("Share"), object: nil)
            case .Location : NotificationCenter.default.post(name: NSNotification.Name("Location"), object: nil)
            case .Settings : NotificationCenter.default.post(name: NSNotification.Name("Settings"), object: nil)
            case .Logout   : NotificationCenter.default.post(name: NSNotification.Name("Logout"), object: nil)
        }
    }
}


