//
//  SongViewController.swift
//  ReusableXibInStoryboard
//
//  Created by Jackylcs on 08/03/2018.
//  Copyright © 2018 Jacky. All rights reserved.
//

import UIKit

class SongViewController: UIViewController {

    @IBOutlet var songLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Bundle.main.loadNibNamed(String(describing:SongViewController.self), owner: self, options: nil)
    }
    
    
    
}
