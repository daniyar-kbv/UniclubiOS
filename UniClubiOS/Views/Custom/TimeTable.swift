//
//  TimeTable.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/16/20.
//

import Foundation
import UIKit

class TimeTable: UITableView, UITableViewDelegate, UITableViewDataSource {
    static var timeTable: TimeTable!
    static var container: UIView!
    
    var weekday: WeekDay? {
        didSet {
            reloadData()
        }
    }
    
    var timeSelected: ((_ time: LessonTime?)->())?
    var onClose: (()->())?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        register(TimeCell.self, forCellReuseIdentifier: TimeCell.reuseIdentifier)
        rowHeight = StaticSize.size(32)
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        backgroundColor = .white
        
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekday?.lessonTimes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimeCell.reuseIdentifier, for: indexPath) as! TimeCell
        cell.time = weekday?.lessonTimes?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TimeCell
        timeSelected?(cell.time)
        close()
    }
    
    static func show(view: UIView, top: CGFloat, weekday: WeekDay) -> (UIView, TimeTable) {
        container = UIView(frame: CGRect(
            x: StaticSize.size(21),
            y: top,
            width: view.frame.width - StaticSize.size(42),
            height: 0
        ))
        
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.25
        container.layer.shadowRadius = StaticSize.size(4)
        container.layer.shadowOffset = CGSize(width: 0, height: StaticSize.size(4))
        
        timeTable = TimeTable()
        timeTable.weekday = weekday
        
        container.addSubview(timeTable)
        timeTable.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        view.addSubview(container)
        
        view.layoutIfNeeded()
        
        container.frame.size.height = CGFloat(weekday.lessonTimes?.count ?? 0) * timeTable.rowHeight
        
        UIView.animate(withDuration: 0.3, animations: {
            view.layoutIfNeeded()
        })
        
        return (container, timeTable)
    }
    
    func close(completion: (()->())? = nil, withOnClose: Bool = true) {
        superview?.frame.size.height = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.superview?.superview?.layoutIfNeeded()
        }, completion: { finished in
            if finished {
                self.superview?.removeFromSuperview()
                completion?()
            }
        })
        
        if withOnClose {
            self.onClose?()
        }
    }
}
