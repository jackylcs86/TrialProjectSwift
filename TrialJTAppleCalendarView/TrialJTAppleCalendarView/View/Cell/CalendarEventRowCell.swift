//
//  CalendarEventRowCell.swift
//  TrialJTAppleCalendarView
//
//  Created by Jacky Liew on 24/10/2018.
//  Copyright © 2018 Jacky Liew. All rights reserved.
//

import UIKit

class CalendarEventRowCell: UITableViewCell {

    @IBOutlet weak var eventView: CalendarEventRowView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
