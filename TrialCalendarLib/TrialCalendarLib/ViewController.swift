//
//  ViewController.swift
//  TrialCalendarLib
//
//  Created by Jacky Liew on 24/10/2018.
//  Copyright © 2018 Jacky Liew. All rights reserved.
//

import UIKit
import CalendarLib

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBAction func previousAction(_ sender: Any) {
        self.yearViewController.moveToPreviousPageAnimated(animated: true)
    }
    
    @IBAction func todayAction(_ sender: Any) {
//        self.yearViewController.moveToDate(date: Date(), animated: true)
        let currentYear = 2018
        self.yearLabel.text = "\(currentYear)"
        
        if let initialViewController = self.storyboard?.instantiateViewController(withIdentifier: "YearVC") as? YearViewController {
            initialViewController.dateRange = MGCDateRange(start: self.getStart(date: currentYear), end: self.getEnd(date: currentYear))
            initialViewController.currentDate = currentYear
            initialViewController.delegate = self
            self.embededPageViewController.setViewControllers([initialViewController], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
        }
    }
    
    @IBAction func nextAction(_ sender: Any) {
        self.yearViewController.moveToNextPageAnimated(animated: true)
    }
    
    fileprivate var yearViewControllers: [YearViewController] = []
    fileprivate var yearViewController: YearViewController!
    fileprivate var embededPageViewController: UIPageViewController!
    fileprivate var dateFormatter: DateFormatter?
    fileprivate var thisYear: Int { return 2018 }
    fileprivate var minYear: Int { return thisYear - 10 }
    fileprivate var maxYear: Int { return thisYear + 10 }
    
    fileprivate func getStart(date: Int) -> Date {
        dateFormatter?.dateFormat = "yyyy MM dd"
        return self.dateFormatter?.date(from: "\(date)" + " 01 01") ?? Date()
    }
    
    fileprivate func getEnd(date: Int) -> Date {
        dateFormatter?.dateFormat = "yyyy MM dd"
        return self.dateFormatter?.date(from: "\(date)" + " 12 01") ?? Date()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter = DateFormatter()
        
        self.embededPageViewController.delegate = self
        self.embededPageViewController.dataSource = self
        
        self.yearViewControllers = (minYear...maxYear).map { self.genarateYearViewControllers(year: $0) ?? YearViewController() }
        let yearVC = self.getYearViewControllerFor(year: 2018)
        self.embededPageViewController.setViewControllers([yearVC], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pageViewController = segue.destination as? UIPageViewController else { return }
        self.embededPageViewController = pageViewController
    }
    
    fileprivate func genarateYearViewControllers(year: Int) -> YearViewController? {
        let yearViewController = self.storyboard?.instantiateViewController(withIdentifier: "YearVC") as? YearViewController
        yearViewController?.dateRange = MGCDateRange(start: self.getStart(date: year), end: self.getEnd(date: year))
        yearViewController?.currentDate = year
        yearViewController?.delegate = self
        return yearViewController
    }
    
    fileprivate func getYearViewControllerFor(year: Int) -> YearViewController {
        return self.yearViewControllers.filter { $0.currentDate == year }.first ?? YearViewController()
    }
}

extension ViewController: YearViewControllerDelegate {
    func yearViewController(controller: YearViewController, didAppear date: Int) {
        self.yearLabel.text = "\(date)"
    }
    
    func calendarViewController(controller: CalendarViewController, didShowDate date: Date) {
        // Swift must implement all protocol
    }
    
    func calendarViewController(controller: CalendarViewController, didSelectEvent event: AnyObject) {
        // Swift must implement all protocol
    }
    
    func yearViewController(controller: YearViewController, didSelectMonthAtDate date: Date) {
        
    }
}

extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcBefore = viewController as? YearViewController else { return nil }
        let previousYear = vcBefore.currentDate - 1
        
        if previousYear > self.minYear {
            return self.getYearViewControllerFor(year: previousYear)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcAfter = viewController as? YearViewController else { return nil }
        let nextYear = vcAfter.currentDate + 1
        
        if nextYear < self.maxYear {
            return self.getYearViewControllerFor(year: nextYear)
        }
        return nil
    }
    
}
