//
//  SecondViewController.swift
//  ReusableCustomPopUps
//
//  Created by Jackylcs on 02/03/2018.
//  Copyright © 2018 Jacky. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func selectTimeAction(_ sender: Any) {
        let sb = UIStoryboard(name: "DatePopUp", bundle: nil)
        let popupVC = sb.instantiateInitialViewController() as! DatePopupVC
        popupVC.isShowTimePicker = true
        self.present(popupVC, animated: true, completion: nil)
    }
    
}

