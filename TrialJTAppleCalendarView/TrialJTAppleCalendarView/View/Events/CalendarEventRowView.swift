
//
//  CalendarEventRowView.swift
//  TrialJTAppleCalendarView
//
//  Created by Jacky Liew on 24/10/2018.
//  Copyright © 2018 Jacky Liew. All rights reserved.
//

import UIKit
import NibDesignable

class CalendarEventRowViewModel {
    let typeText: String
    var typeIsHidden: Bool { return self.typeText.isEmpty }
    let mainTitleText: String
    var mainTitleIsHidden: Bool { return self.mainTitleText.isEmpty && self.typeText.isEmpty }
    let subTitleText: String
    var subTitleIsHidden: Bool { return self.subTitleText.isEmpty }
    let timeText: String
    var timeIsHidden: Bool { return self.timeText.isEmpty }
    let locationText: String
    var locationIsHidden: Bool { return self.locationText.isEmpty }
    var backgroundColor: UIColor { return .purple }
    
    init(response: EventResponse) {
        self.typeText = "SERVICE"
        self.mainTitleText = response.title
        self.subTitleText = response.subTitle
        self.timeText = response.time
        self.locationText = response.location
    }
}

class CalendarEventRowView: NibDesignable {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var mainTitleRowView: UIStackView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationRowView: UIStackView!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet var baseTapGesture: UITapGestureRecognizer!
    
//    var viewModel: ContactLeadReminderRowViewModel!
    
    // MARK: - Implementation -
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        
    }

    func config(viewModel: CalendarEventRowViewModel) {
        self.typeLabel.text = viewModel.typeText
        self.typeLabel.isHidden = viewModel.typeIsHidden
        
        self.mainTitleLabel.text = viewModel.mainTitleText
        self.mainTitleRowView.isHidden = viewModel.mainTitleIsHidden
        
        self.subTitleLabel.text = viewModel.subTitleText
        self.subTitleLabel.isHidden = viewModel.subTitleIsHidden
        
        self.timeLabel.text = viewModel.timeText
        self.timeLabel.isHidden = viewModel.timeIsHidden
        
        self.locationLabel.text = viewModel.locationText
        self.locationRowView.isHidden = viewModel.locationIsHidden
        
        self.bgView.backgroundColor = viewModel.backgroundColor
    }
}
