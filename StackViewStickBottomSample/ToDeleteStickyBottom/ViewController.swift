//
//  ViewController.swift
//  ToDeleteStickyBottom
//
//  Created by Jacky Liew on 12/03/2020.
//  Copyright © 2020 Jacky Liew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var someView: UIView!
    @IBOutlet weak var someVIewHeightConstraint: NSLayoutConstraint!
    
    var isHidden: Bool = false
    
    @IBAction func showHideAction(_ sender: Any) {
        
        isHidden = !isHidden
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let `self` = self else { return } // Return if self is disposed
            self.someView.isHidden = self.isHidden
            self.someVIewHeightConstraint.constant = (self.isHidden) ? 0 : 600
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

