//
//  ProfileViewModel.swift
//  MultipleCellTypes
//
//  Created by Jackylcs on 08/03/2018.
//  Copyright © 2018 Jacky. All rights reserved.
//

import UIKit

class ProfileViewModel: NSObject {
    var items = [ProfileViewModelItem]()
    
    init(profile: Profile) {
        super.init()
        guard let data = dataFromFile("ServerData"), let profile = Profile(data: data) else {
            return
        }
        
        if let name = profile.fullName, let pictureUrl = profile.pictureUrl {
            let nameAndPictureItem = ProfileViewModelNameAndPictureItem(pictureUrl: pictureUrl, userName: name)
            items.append(nameAndPictureItem)
        }
        
        if let about = profile.about {
            let aboutItem = ProfileViewModelAboutItem(about: about)
            items.append(aboutItem)
        }
        
        if let email = profile.email {
            let dobItem = ProfileViewModelEmailItem(email: email)
            items.append(dobItem)
        }
        
        let attributes = profile.profileAttributes
        // we only need attributes item if attributes not empty
        if !attributes.isEmpty {
            let attributesItem = ProfileViewModelAttributeItem(attributes: attributes)
            items.append(attributesItem)
        }
        
        let friends = profile.friends
        // we only need friends item if friends not empty
        if !profile.friends.isEmpty {
            let friendsItem = ProfileViewModeFriendsItem(friends: friends)
            items.append(friendsItem)
        }
        
    }
}

// MARK: Outsource DataSource (not working, cellForRow not function, moved back to View Controller)
//extension ProfileViewModel: UITableViewDataSource {
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return items.count
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items[section].rowCount
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let item = items[indexPath.row]
//        
//        let reuseId = "ReuseMe"
//        var cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as UITableViewCell
//        if (cell == nil) {
//            cell = UITableViewCell(style: .default, reuseIdentifier: reuseId)
//        }
//        
//        cell.textLabel?.text = item.sectionTitle
//        return cell
//    }
//    
//}




