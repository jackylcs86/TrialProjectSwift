//
//  ViewController.swift
//  TrialContainerViewController
//
//  Created by Jacky Liew on 26/10/2018.
//  Copyright © 2018 Jacky Liew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var container: ContainerViewController?
    
    @IBAction func segmentChanged(_ sender: Any) {
        let segment = sender as! UISegmentedControl
        if segment.selectedSegmentIndex == 0 {
            self.container?.showYearCalendar()
        } else {
            self.container?.showMonthCalendar()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        self.container = segue.destination as? ContainerViewController
    }
}

