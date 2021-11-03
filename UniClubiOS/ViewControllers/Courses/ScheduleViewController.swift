//
//  ScheduleViewController.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/16/20.
//

import Foundation
import UIKit

class ScheduleViewController: UIViewController {
    lazy var scheduleView = ScheduleView(withBar: false)
    var course: CourseFull? {
        didSet {
            loadCells()
            scheduleView.tableView.reloadData()
            scheduleView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: scheduleView.tableView.contentInset.bottom + (StaticSize.size(32) * CGFloat(course?.weekdays?.last?.lessonTimes?.count ?? 0)), right: 0)
        }
    }
    var openedTable: (UIView, TimeTable)?
    var superVc: СourseDetailViewController?
    var cells: [ScheduleCell] = []
    
    override func viewDidLoad() {
        super.loadView()
        
        view = scheduleView
        
        scheduleView.tableView.delegate = self
        scheduleView.tableView.dataSource = self
        
        scheduleView.onTouch = onViewTouch
        
        scheduleView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func openTimeTable(_ cell: ScheduleCell?) {
        guard let maxY = cell?.frame.maxY, let weekday = cell?.weekday, (openedTable?.1 == nil || (openedTable?.1 != nil && openedTable?.1.weekday?.id != cell?.weekday?.id)) else { return }
        var opened: (UIView, TimeTable)?
        openedTable?.1.close(withOnClose: false)
        opened = TimeTable.show(view: scheduleView.tableView, top: maxY, weekday: weekday)
        opened?.1.onClose = onTableClose
        opened?.1.timeSelected = { time in
            cell?.selectedTime = time
            cell?.isActive = true
            self.check()
        }
        openedTable = opened
    }
    
    func onTableClose() {
        openedTable = nil
    }
    
    func onViewTouch() {
        openedTable?.1.close()
    }
    
    func loadCells() {
        cells.removeAll()
        for i in 0..<(course?.weekdays?.count ?? 0) {
            let cell = scheduleView.tableView.dequeueReusableCell(withIdentifier: ScheduleCell.reuseIdentifier, for: IndexPath(row: i, section: 0)) as! ScheduleCell
            cells.append(cell)
        }
    }
    
    func check() {
        var count = 0
        for cell in cells{
            if cell.isActive {
                count += 1
            }
        }
        scheduleView.button.isActive = count > 0
    }
    
    @objc func buttonTapped() {
        var newTimes: [LessonTime] = []
        for cell in cells{
            if let time = cell.selectedTime, cell.isActive {
                newTimes.append(time)
            }
        }
        if !(superVc?.selectedTimes?.isEmpty ?? true) {
            superVc?.buttonState = .apply
        } else {
            superVc?.buttonState = !newTimes.isEmpty ?
                .addToCart :
                .chooseSchedule
        }
        superVc?.selectedTimes = newTimes
        dismiss(animated: true, completion: nil)
    }
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cells[indexPath.row]
        cell.weekday = course?.weekdays?[indexPath.row]
        cell.openTimeTable = openTimeTable(_:)
        if let time = cell.weekday?.lessonTimes?.first(where: { time in
            superVc?.selectedTimes?.contains(where: { selectedTime in
                selectedTime.id == time.id
            }) ?? false
        }){
            cell.selectedTime = time
            cell.isActive = true
            check()
        }
        return cell
    }
}
