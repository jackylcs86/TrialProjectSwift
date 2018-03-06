//
//  DatePopupVC.swift
//  ReusableCustomPopUps
//
//  Created by Jackylcs on 02/03/2018.
//  Copyright © 2018 Jacky. All rights reserved.
//

import UIKit

class DatePopupVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    var isShowTimePicker: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDatePicker()
        let str = isShowTimePicker ? "time" : "date"
        print("Should show \(str)")
    }
    
    func setupDatePicker() {
        if isShowTimePicker == true {
            titleLabel.text = "Select Time"
            datePicker.datePickerMode = .time
            saveButton.setTitle("Save Time", for: .normal)
        }
        else {
            titleLabel.text = "Select Date"
            datePicker.datePickerMode = .date
            saveButton.setTitle("Save Date", for: .normal)
        }
    }

    @IBAction func saveDateAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
