//
//  YearViewController.swift
//  TestCalendarLib
//
//  Created by eanton on 23/06/16.
//  Copyright © 2016 eanton. All rights reserved.
//

import Foundation
import CalendarLib


protocol YearViewControllerDelegate: CalendarViewControllerDelegate {
    func yearViewController(controller:YearViewController, didSelectMonthAtDate date: Date)
    func yearViewController(controller:YearViewController, didAppear date: Int)
}

class YearViewController: UIViewController {
    
    var yearCalendarView: MGCYearCalendarView? {
        get {
            return self.view as? MGCYearCalendarView
        }
    }
    var delegate: YearViewControllerDelegate?
    var lastSelectedDate: Date?
    var dateRange: MGCDateRange?
    var currentDate: Int = 0
    
    fileprivate var calendar: Calendar = Calendar.current
    fileprivate var dateFormatter: DateFormatter?
    internal var centerDate: Date? {
        get{
            let visibleRange = self.yearCalendarView?.visibleMonthsRange
            if visibleRange != nil {
                let monthCount = self.calendar.dateComponents([Calendar.Component.month], from: visibleRange!.start, to: visibleRange!.end).month
                var comp = DateComponents()
                comp.day = monthCount! / 2;
                
                let centerDate = self.calendar.date(byAdding: comp, to: visibleRange!.start)
                
                let startOfWeekDateComponents = self.calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: centerDate!)
                let startOfWeek = self.calendar.date(from: startOfWeekDateComponents)
                return startOfWeek
            }
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lastSelectedDate = nil
        
        dateFormatter = DateFormatter()
        dateFormatter?.calendar = self.calendar
        dateFormatter?.dateFormat = "yyyy MM dd"
        
        self.yearCalendarView!.delegate = self;
        self.yearCalendarView!.calendar = self.calendar
        self.yearCalendarView!.dateRange = self.dateRange
        self.yearCalendarView?.backgroundColor = .clear

        
        dateFormatter?.dateFormat = "yyyy"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.delegate?.yearViewController(controller: self, didAppear: self.currentDate)
    }
    
    override func loadView() {
        print("loadView")
        let view: MGCYearCalendarView = MGCYearCalendarView(frame: .null)
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.view = view
    }
   
}

extension YearViewController: CalendarViewControllerNavigation {
    func moveToDate(date: Date, animated: Bool) {
        print("Move to Date")
        self.lastSelectedDate = date
        self.yearCalendarView?.scroll(to: date, animated: animated)
    }
    
    func moveToNextPageAnimated(animated: Bool) {
        print("Move to next page")
        var comps = DateComponents()
        comps.year = 1
        
        let date = self.calendar.date(byAdding: comps, to: self.yearCalendarView!.visibleMonthsRange.start)
        self.moveToDate(date: date!, animated: animated)
    }
    
    func moveToPreviousPageAnimated(animated: Bool) {
        print("Move to previous page")
        var comps = DateComponents()
        comps.year = -1
        
        let date = self.calendar.date(byAdding: comps, to: self.yearCalendarView!.visibleMonthsRange.start)
        self.moveToDate(date: date!, animated: animated)
    }
}

extension YearViewController: MGCYearCalendarViewDelegate {
    func calendarYearViewDidScroll(_ view: MGCYearCalendarView!) {
        print("calendarYearViewDidScroll")
        if let lastSelectedDate = lastSelectedDate {
            self.delegate?.calendarViewController(controller: self, didShowDate: lastSelectedDate)
        } else {
            let date = self.yearCalendarView?.dateForMonth(at: self.yearCalendarView!.center)
            if let date = date {
                self.delegate?.calendarViewController(controller: self, didShowDate: date)
            }
        }
    }
    
    func calendarYearView(_ view: MGCYearCalendarView!, didSelectMonthAt date: Date?) {
        print("didSelectMonthAt")
        guard let selectedDate = date else { return }
        self.delegate?.yearViewController(controller: self, didSelectMonthAtDate: selectedDate)
    }
    
    func heightForYearHeader(inCalendarYearView view: MGCYearCalendarView!) -> CGFloat {
        return 0
    }
}
