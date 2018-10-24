//
//  ListingHeaderView.swift
//  AIAAgent
//
//  Created by Khong on 07/08/2018.
//  Copyright © 2018 lee yee chuan. All rights reserved.
//

import UIKit

class ListingHeaderView: UITableViewHeaderFooterView, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var customBackgroundColor: UIColor = UIColor(red: 242/255, green: 237/255, blue: 226/255, alpha: 1.0)
    var isDarkBackground:Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            bgView.backgroundColor = customBackgroundColor
        }
    }
}
