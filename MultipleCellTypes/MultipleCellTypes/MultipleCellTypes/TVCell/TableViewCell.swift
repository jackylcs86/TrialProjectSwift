//
//  TableViewCell.swift
//  MultipleCellTypes
//
//  Created by Jackylcs on 09/03/2018.
//  Copyright © 2018 Jacky. All rights reserved.
//

import UIKit

class NameAndPictureCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    static let CellIdNameAndPicture: String = "CellId_NameAndPicture"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pictureImageView.layer.cornerRadius = self.pictureImageView.frame.size.width/2
        self.pictureImageView.clipsToBounds = true;
    }
    
    var item: ProfileViewModelItem? {
        didSet {
            // cast the ProfileViewModelItem to appropriate item type
            guard let item = item as? ProfileViewModelNameAndPictureItem  else {
                return
            }
            nameLabel?.text = item.userName
            pictureImageView!.image = UIImage(named: item.pictureUrl)
        }
    }

}

class AboutCell: UITableViewCell {
    
    @IBOutlet weak var aboutLabel: UILabel!
    static let CellIdAbout: String = "CellId_About"
    
    var item: ProfileViewModelItem? {
        didSet {
            guard  let item = item as? ProfileViewModelAboutItem else {
                return
            }
            aboutLabel!.text = item.about
        }
    }
}

class EmailCell: UITableViewCell {
    
    @IBOutlet weak var emailLabel: UILabel!
    static let CellIdEmail: String = "CellId_Email"

    var item: ProfileViewModelItem? {
        didSet {
            guard let item = item as? ProfileViewModelEmailItem else {
                return
            }
            emailLabel!.text = item.email
        }
    }
}

class AttributeCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    static let CellIdAttribute: String = "CellId_Atrribute"
    
    var item: Attribute?  {
        didSet {
            titleLabel!.text = item?.key
            valueLabel!.text = item?.value
        }
    }
    
}

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    static let CellIdFriend: String = "CellId_Friend"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.pictureImageView.layer.cornerRadius = self.pictureImageView.frame.size.width/2
        self.pictureImageView.clipsToBounds = true;
    }
    
    var item: Friend? {
        didSet {
            guard let item = item else {
                return
            }
            if let pictureUrl = item.pictureUrl {
                pictureImageView?.image = UIImage(named: pictureUrl)
            }
            nameLabel!.text = item.name
        }
    }
}



