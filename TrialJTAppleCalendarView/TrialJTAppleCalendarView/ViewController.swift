//
//  ViewController.swift
//  TrialJTAppleCalendarView
//
//  Created by Jacky Liew on 23/10/2018.
//  Copyright © 2018 Jacky Liew. All rights reserved.
//

import UIKit
import JTAppleCalendar

struct AIAColors {
    static var myGray: UIColor { return UIColor(red: 90/255, green: 109/255, blue: 132/255, alpha: 1.0)}
}
struct EventResponse {
    let date: Date?
    let title: String
    let id: String
}

struct EventModel {
    let title: String
    let id: String
    let date: Date
}

class ViewController: UIViewController {
    
    @IBOutlet weak var myCalendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    
    var eventByDate: [String : [EventModel]] = [:]
    
    let myCalendar = Calendar.current
    var myDateFormatter: DateFormatter {
        let  dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.timeZone = self.myCalendar.timeZone
        dateFormatter.locale = self.myCalendar.locale
        return dateFormatter
    }
    
    @IBAction func navToToday(_ sender: Any) {
        self.myCalendarView.scrollToDate(Date())
        self.myCalendarView.selectDates([Date()])
    }
    @IBAction func navToPrevMonth(_ sender: Any) {
        self.myCalendarView.scrollToSegment(.previous)
    }
    @IBAction func navToNextMonth(_ sender: Any) {
        self.myCalendarView.scrollToSegment(.next)
    }
    @IBAction func changeCalendarMode(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCalendarView()
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.createMockEvent()
            DispatchQueue.main.async {
                self.myCalendarView.reloadData()
            }
        }
        
    }
    
    fileprivate func setupCalendarView() {
        self.myCalendarView.minimumLineSpacing = 0
        self.myCalendarView.minimumInteritemSpacing = 0
        self.myCalendarView.scrollToDate(Date(), animateScroll: false)
        self.myCalendarView.selectDates([Date()])
        self.myCalendarView.visibleDates { (visibleDates: DateSegmentInfo) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }

    fileprivate func configureVisibleCell(myCustomCell: CellView, cellState: CellState, date: Date) {
        myCustomCell.dayLabel.text = cellState.text
        
        // Today
        if myCalendar.isDateInToday(date) {
            myCustomCell.dayLabel.textColor = (cellState.isSelected == true) ? .white : .red
            myCustomCell.selectedView.isHidden = (cellState.isSelected == false)
        }
        // This Month
        else if cellState.dateBelongsTo == .thisMonth {
            myCustomCell.dayLabel.textColor = (cellState.isSelected == true) ? .white : .black
            myCustomCell.selectedView.isHidden = (cellState.isSelected == false)
        }
        // Other Month
        else {
            myCustomCell.dayLabel.textColor = (cellState.isSelected == true) ? .lightGray : .lightGray
            myCustomCell.selectedView.isHidden = true
        }

        myCustomCell.dotView.isHidden = (self.eventByDate.contains { $0.key == self.myDateFormatter.string(from: cellState.date) } == false)
        myCustomCell.selectedView.backgroundColor = .red
        
        handleCellConfiguration(cell: myCustomCell, cellState: cellState)
    }
    
    fileprivate func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else { return }
        let month = self.myCalendar.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
//        let year = self.myCalendar.component(.year, from: startDate)
        self.monthLabel.text = monthName.uppercased()
        
    }

    fileprivate func handleCellConfiguration(cell: JTAppleCell?, cellState: CellState) {
//        handleCellSelection(view: cell, cellState: cellState)
//        handleCellTextColor(view: cell, cellState: cellState)
//        prePostVisibility?(cellState, cell as? CellView)
    }
    
    private func createMockEvent() {
        let serverResponse = [
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 01"), title: "Sleeping", id: "1"),
            EventResponse(date: self.myDateFormatter.date(from: "ABC 123"), title: "Error Event", id: "404"),
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 01"), title: "Dota2", id: "2"),
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 03"), title: "Marvel Strike Force", id: "3"),
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 13"), title: "Pokemon", id: "4"),
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 06"), title: "Flappy Bird", id: "5"),
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 20"), title: "Mobile Legend", id: "6"),
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 06"), title: "HAHHAHA", id: "7"),
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 22"), title: "PUBG", id: "8"),
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 09"), title: "Drinking", id: "9"),
        ]
        
        var temp: [String: [EventModel]] = [:]
        for event in serverResponse {
            guard let eventDate = event.date else { continue }
            let key = self.myDateFormatter.string(from: eventDate)
            if temp[key] == nil {
                temp[key] = []
            }
            let eventModel = EventModel(title: event.title, id: event.id, date: eventDate)
            temp[key]?.append(eventModel)
        }
        self.eventByDate = temp
    }
}


extension ViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let startDate = self.myDateFormatter.date(from: "2018 01 01")!
        let endDate = self.myDateFormatter.date(from: "2019 02 01")!
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
}

extension ViewController: JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: "CellView", for: indexPath) as! CellView
        self.calendar(calendar, willDisplay: myCustomCell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return myCustomCell
    }
    
    // Library said must implement this to avoid bug
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? CellView else { return }
       self.configureVisibleCell(myCustomCell: cell, cellState: cellState, date: date)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setupViewsOfCalendar(from: visibleDates)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let cell = cell as? CellView else { return }
        switch cellState.dateBelongsTo {
        case .thisMonth:
            self.configureVisibleCell(myCustomCell: cell, cellState: cellState, date: date)
            cell.selectedView.bounce()
        case .previousMonthWithinBoundary:
            self.myCalendarView.scrollToSegment(.previous)
            self.configureVisibleCell(myCustomCell: cell, cellState: cellState, date: date)
        case .followingMonthWithinBoundary:
            self.myCalendarView.scrollToSegment(.next)
            self.configureVisibleCell(myCustomCell: cell, cellState: cellState, date: date)
        default:
            break
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let cell = cell as? CellView else { return }
        self.configureVisibleCell(myCustomCell: cell, cellState: cellState, date: date)
        
    }
}

extension UIView {
    fileprivate func bounce() {
        self.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
        UIView.transition(with: self, duration: 0.1, options: [], animations: {
            self.transform = CGAffineTransform.identity
        })
    }
}
