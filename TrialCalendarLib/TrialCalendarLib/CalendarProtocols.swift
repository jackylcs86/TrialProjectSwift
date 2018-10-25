//
//  CalendarProtocols.swift
//  TestCalendarLib
//
//  Created by eanton on 21/06/16.
//  Copyright © 2016 eanton. All rights reserved.
//
import UIKit
import CalendarLib

protocol CalendarViewControllerNavigation {
    var centerDate: Date? { get }
    func moveToDate(date: Date, animated: Bool)
    func moveToNextPageAnimated(animated: Bool)
    func moveToPreviousPageAnimated(animated: Bool)

}

typealias CalendarViewController = NSObjectProtocol & CalendarViewControllerNavigation

protocol CalendarViewControllerDelegate {
    func calendarViewController(controller: CalendarViewController, didShowDate date: Date)
    func calendarViewController(controller: CalendarViewController, didSelectEvent event: AnyObject)
}
