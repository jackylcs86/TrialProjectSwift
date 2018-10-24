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
    let subTitle: String
    let time: String
    let location: String
    let id: String
    
    init(date: Date?, title: String, id: String, subTitle: String = "", time: String = "", location: String = "") {
        self.date = date
        self.title = title
        self.subTitle = subTitle
        self.time = time
        self.location = location
        self.id = id
    }
}

//struct EventModel {
//    let title: String
//    let id: String
//    let date: Date
//}

class ViewController: UIViewController {
    
    @IBOutlet weak var myCalendarView: JTAppleCalendarView!
    @IBOutlet weak var myCalendarViewHeight: NSLayoutConstraint!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarModeButton: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    
    var eventByDate: [String : [CalendarEventRowViewModel]] = [:]
    var selectedDate: Date = Date() {
        didSet {
            self.myTableView.reloadData()
        }
    }
    var isDailyMode: Bool = false
    let myCalendar = Calendar.current
    var numberOfRows = 6
    var myDateFormatter: DateFormatter {
        let  dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.timeZone = self.myCalendar.timeZone
        dateFormatter.locale = self.myCalendar.locale
        return dateFormatter
    }
    
    @IBAction func navToToday(_ sender: Any) {
        self.selectedDate = Date()
        self.scrollToSelectedDate()
    }
    @IBAction func navToPrevMonth(_ sender: Any) {
        self.myCalendarView.scrollToSegment(.previous)
    }
    @IBAction func navToNextMonth(_ sender: Any) {
        self.myCalendarView.scrollToSegment(.next)
    }
    
    @IBAction func changeCalendarMode(_ sender: Any) {
        self.isDailyMode.toggle()
        
        let buttonTitle = (self.isDailyMode == true) ? "DAY" : "MONTH"
        self.calendarModeButton.setTitle(buttonTitle, for: .normal)
        
        let newHeight = (self.isDailyMode == true) ? 60.0 : 280.0
        self.myCalendarViewHeight.constant = CGFloat(newHeight)
        
        self.numberOfRows = (self.isDailyMode == true) ? 1 : 6
        
        self.myCalendarView.layoutIfNeeded()
        self.myCalendarView.reloadData()
        self.scrollToSelectedDate()
    }
    
    // MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupCalendarView()
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.createMockEvent()
            DispatchQueue.main.async {
                self.myCalendarView.reloadData()
                self.myTableView.reloadData()
            }
        }
        
    }
    
    fileprivate func setupTableView() {
        self.myTableView.register(UINib(nibName: "ListingHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ListingHeaderView")
        self.myTableView.register(UINib(nibName: "CalendarEventRowCell", bundle: nil), forCellReuseIdentifier: "EventRowCellId")
        self.myTableView.tableFooterView = UIView()
        self.myTableView.estimatedRowHeight = UITableView.automaticDimension
        self.myTableView.rowHeight = UITableView.automaticDimension
        self.myTableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        self.myTableView.sectionHeaderHeight = UITableView.automaticDimension
        self.myTableView.separatorStyle = .none
    }
    
    fileprivate func setupCalendarView() {
        self.myCalendarView.minimumLineSpacing = 0
        self.myCalendarView.minimumInteritemSpacing = 0
        self.scrollToSelectedDate()
    }
    
    fileprivate func scrollToSelectedDate() {
        self.myCalendarView.scrollToDate(self.selectedDate, animateScroll: false)
        self.myCalendarView.selectDates([self.selectedDate])
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
        
    }
    
    fileprivate func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else { return }
        let month = self.myCalendar.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
//        let year = self.myCalendar.component(.year, from: startDate)
        self.monthLabel.text = monthName.uppercased()
        
    }

    private func createMockEvent() {
        let serverResponse = [
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 01"), title: "Sleeping", id: "1", subTitle: "Sleeping is good for Health"),
            EventResponse(date: self.myDateFormatter.date(from: "ABC 123"), title: "Error Event", id: "404"),
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 01"), title: "Dota2", id: "2", location: "MacDonald"),
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 03"), title: "Marvel Strike Force", id: "3"),
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 13"), title: "Pokemon", id: "4"),
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 06"), title: "Flappy Bird", id: "5"),
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 20"), title: "Mobile Legend", id: "6"),
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 06"), title: "HAHHAHA", id: "7"),
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 22"), title: "PUBG", id: "8"),
            EventResponse(date: self.myDateFormatter.date(from: "2018 10 09"), title: "Drinking", id: "9"),
            EventResponse(date: Date(), title: "Hari Raya", id: "9", subTitle: "Balik kampung"),
            EventResponse(date: Date(), title: "Hari Raya", id: "9", location: "Petaling Jaya"),
            EventResponse(date: Date(), title: "Lunch Time", id: "9", time: "12:00pm - 3:00pm"),
            EventResponse(date: Date(), title: "Hari Raya", id: "9", subTitle: "Balik kampung", time: "12:00pm - 3:00pm", location: "Petaling Jaya")
        ]
        
        var temp: [String: [CalendarEventRowViewModel]] = [:]
        for event in serverResponse {
            guard let eventDate = event.date else { continue }
            let key = self.myDateFormatter.string(from: eventDate)
            if temp[key] == nil {
                temp[key] = []
            }
            let eventViewModel = CalendarEventRowViewModel(response: event)
            temp[key]?.append(eventViewModel)
        }
        self.eventByDate = temp
    }
}

// MARK: - JTAppleCalendarView -
extension ViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let startDate = self.myDateFormatter.date(from: "2018 01 01")!
        let endDate = self.myDateFormatter.date(from: "2019 01 01")!
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: self.numberOfRows)
        return parameters
    }
    
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
        self.selectedDate = date
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

// MARK: - UITableView -
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = self.myDateFormatter.string(from: self.selectedDate)
        return self.eventByDate[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventRowCellId") as? CalendarEventRowCell else { return UITableViewCell() }
        
        let key = self.myDateFormatter.string(from: self.selectedDate)
        guard let eventList = self.eventByDate[key] else { return UITableViewCell() }
        
        let viewModel = eventList[indexPath.row]
        cell.eventView.config(viewModel: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let listingHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ListingHeaderView") as? ListingHeaderView else {
            return UITableViewHeaderFooterView()
        }
        let dateFormatter = self.myDateFormatter
        dateFormatter.dateFormat = "EEEE, dd MMM"
        
        listingHeaderView.titleLabel.text = dateFormatter.string(from: self.selectedDate)
        return listingHeaderView
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
