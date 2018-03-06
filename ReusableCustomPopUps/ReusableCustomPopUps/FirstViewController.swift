//
//  FirstViewController.swift
//  ReusableCustomPopUps
//
//  Created by Jackylcs on 02/03/2018.
//  Copyright © 2018 Jacky. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! DatePopupVC
        destVC.isShowTimePicker = false
    }
}

