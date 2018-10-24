
//
//  CalendarEventRowView.swift
//  TrialJTAppleCalendarView
//
//  Created by Jacky Liew on 24/10/2018.
//  Copyright © 2018 Jacky Liew. All rights reserved.
//

import UIKit
import NibDesignable

enum EnumCalendarEventType: String {
    case sales = "SALES"
    case recruit = "RECRUIT"
    case service = "SERVICE"
    case event = "EVENT"
    case training = "TRAINING"
    case coach = "COACHING/REVIEW"
    case other = "OTHER"
    case personal = "PERSONAL"
    case reminder = "REMINDER"
    
    var backgroundColor: UIColor {
        switch self {
        case .sales: return self.colorWithHexString(hex: "39C089")
        case .recruit: return self.colorWithHexString(hex: "F5A83B")
        case .service: return self.colorWithHexString(hex: "E03572")
        case .event: return self.colorWithHexString(hex: "1C7689")
        case .training: return self.colorWithHexString(hex: "A03FB8")
        case .coach: return self.colorWithHexString(hex: "1C8AED")
        case .other: return self.colorWithHexString(hex: "5A6C80")
        case .personal: return self.colorWithHexString(hex: "5367B4")
        case .reminder: return self.colorWithHexString(hex: "9D9D9D")        }
    }
    
    static func normalized(_ value:String) -> String {
        return value
            .replacingOccurrences(of: " ", with: "")
            .uppercased()
    }
    static let cases: [EnumCalendarEventType] = [.sales, .recruit, .service, .event, .training, .coach, .other, .personal, .reminder]
    
    init?(rawValue: String) {
        let newValue = EnumCalendarEventType.normalized(rawValue)
        if let index = EnumCalendarEventType.cases.index(where: {$0.rawValue == newValue}) {
            self = EnumCalendarEventType.cases[index]
        } else {
            return nil
        }
    }
    
    private func colorWithHexString(hex: String) -> UIColor {
        
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}

class CalendarEventRowViewModel {
    var typeText: String = ""
    var typeIsHidden: Bool { return self.typeText.isEmpty }
    let mainTitleText: String
    var mainTitleIsHidden: Bool { return self.mainTitleText.isEmpty && self.typeText.isEmpty }
    let subTitleText: String
    var subTitleIsHidden: Bool { return self.subTitleText.isEmpty }
    let timeText: String
    var timeIsHidden: Bool { return self.timeText.isEmpty }
    let locationText: String
    var locationIsHidden: Bool { return self.locationText.isEmpty }
    var backgroundColor: UIColor = UIColor.white
    
    init(response: EventResponse) {
        self.mainTitleText = response.title
        self.subTitleText = response.subTitle
        self.timeText = response.time
        self.locationText = response.location
        
        if let type: EnumCalendarEventType = EnumCalendarEventType(rawValue: response.type) {
            self.typeText = type.rawValue
            self.backgroundColor = type.backgroundColor
        }
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
