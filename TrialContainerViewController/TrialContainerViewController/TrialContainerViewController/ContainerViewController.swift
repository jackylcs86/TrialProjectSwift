//
//  ContainerViewController.swift
//  TrialContainerViewController
//
//  Created by Jacky Liew on 26/10/2018.
//  Copyright © 2018 Jacky Liew. All rights reserved.
//

import UIKit

class EmptySegue: UIStoryboardSegue {
    override func perform() {
        
    }
}

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.performSegue(withIdentifier: "A", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if self.children.count > 0 {
            self.swap(fromVC: self.children.first!, toVC: segue.destination)
        } else {
            self.firstInit(segue: segue)
        }
    }
    
    private func firstInit(segue: UIStoryboardSegue) {
        guard let destView = segue.destination.view else { return }
        self.addChild(segue.destination)
        destView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        destView.frame = self.view.bounds
        self.view.addSubview(destView)
        segue.destination.didMove(toParent: self)
    }
    
    private func swap(fromVC: UIViewController, toVC: UIViewController) {
        
        self.addChild(toVC)
        toVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        toVC.view.frame = self.view.bounds
        self.view.addSubview(toVC.view)
        toVC.didMove(toParent: self)
        
        fromVC.willMove(toParent: nil)
        fromVC.removeFromParent()
    }
    
    func showYearCalendar() {
        self.performSegue(withIdentifier: "A", sender: nil)
    }
    
    func showMonthCalendar() {
        self.performSegue(withIdentifier: "B", sender: nil)
    }
    
}
