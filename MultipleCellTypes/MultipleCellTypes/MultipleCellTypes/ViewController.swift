//
//  ViewController.swift
//  MultipleCellTypes
//
//  Created by Jackylcs on 08/03/2018.
//  Copyright © 2018 Jacky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var items = [ProfileViewModelItem]()
    let reuseId = "ReuseMe"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profile = Profile(data: dataFromFile("ServerData")!)
        let profileViewModel = ProfileViewModel(profile: profile!)
        
        print("Did I get profile :: \(String(describing: profile))")
        print("Did I get profileViewModel :: \(String(describing: profileViewModel))")
        print("In profileViewModel, I have :: \(profileViewModel.items)" )
        
        self.items = profileViewModel.items
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
}

// MARK: Outsource DataSource
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch items[indexPath.section].type {
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.section]
        
        switch item.type {
        case .nameAndPicture:
            if let cell = tableView.dequeueReusableCell(withIdentifier: NameAndPictureCell.CellIdNameAndPicture, for: indexPath) as? NameAndPictureCell {
                cell.item = item
                return cell
            }
        case .about:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AboutCell.CellIdAbout, for: indexPath) as? AboutCell {
                cell.item = item
                return cell
            }
        case .email:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EmailCell.CellIdEmail, for: indexPath) as? EmailCell {
                cell.item = item
                return cell
            }
        case .friend:
            if let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.CellIdFriend, for: indexPath) as? FriendCell {
                cell.item = (item as! ProfileViewModeFriendsItem).friends[indexPath.row]
                return cell
            }
        case .attribute:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AttributeCell.CellIdAttribute, for: indexPath) as? AttributeCell {
                cell.item = (item as! ProfileViewModelAttributeItem).attributes[indexPath.row]
                return cell
            }
        }
        
        return UITableViewCell()
        
        /* code to use default cell, but not working
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) // This one is !
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseId) // This one is ?
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseId)
        }
        
        cell!.textLabel?.text = item.sectionTitle
        cell!.detailTextLabel?.text = "subtitle"
        return cell!
 */
    }
    
}

