//
//  ScheduleCell.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/15/20.
//

import Foundation
import UIKit
import SnapKit

class ScheduleCell: UITableViewCell {
    static let reuseIdentifier = "ScheduleCell"
    var weekday: WeekDay? {
        didSet {
            title.text =  WeekDays(rawValue: weekday?.day ?? 0)?.name
            if weekday?.lessonTimes?.isEmpty ?? true {
                addSubview(transparentView)
                
                transparentView.snp.makeConstraints({
                    $0.edges.equalToSuperview()
                })
            }
        }
    }
    var isActive = false {
        didSet {
            UIView.animate(withDuration: 0.5, animations: { [self] in
                if isActive && selectedTime == nil {
                    isActive = false
                }
                timeTitle.textColor = isActive ? .customDarkBlue : .customLightGray
                checkBox.setBackgroundImage(UIImage(named: isActive ? "checkBoxOnGreen" : "checkBoxOff"), for: .normal)
                self.layoutIfNeeded()
            })
        }
    }
    var openTimeTable: ((_ cell: ScheduleCell?)->())?
    var selectedTime: LessonTime? {
        didSet {
            timeTitle.text = selectedTime != nil ?
                "\(selectedTime?.fromTime?.getRange(end: 5) ?? "") - \(selectedTime?.toTime?.getRange(end: 5) ?? "")" :
                "Выберите время"
            timeTitle.textColor = selectedTime != nil ? .customDarkBlue : .customLightGray
            UIView.animate(withDuration: 0.5, animations: {
                self.checkBox.isHidden = false
                self.layoutIfNeeded()
            })
        }
    }
    
    lazy var transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        return view
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(22), weight: .regular)
        label.textColor = .customDarkBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var checkBox: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "checkBoxOff"), for: .normal)
        view.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        view.isHidden = true
        return view
    }()
    
    lazy var timeButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = StaticSize.size(5)
        view.layer.borderWidth = StaticSize.size(0.5)
        view.layer.borderColor = UIColor.customLightGray.cgColor
        view.addTarget(self, action: #selector(timeTapped), for: .touchUpInside)
        return view
    }()
    
    lazy var timeTitle: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(StaticSize.size(16)), weight: .regular)
        label.textColor = .customLightGray
        label.adjustsFontSizeToFitWidth = true
        label.text = "Выберите время"
        label.isUserInteractionEnabled = false
        return label
    }()

    lazy var rightArrow: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrowDown")
        view.isUserInteractionEnabled = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([checkBox, title, timeButton])
        
        checkBox.snp.makeConstraints({
            $0.right.top.equalToSuperview().inset(StaticSize.size(15))
            $0.size.equalTo(StaticSize.size(32))
        })
        
        title.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.size(15))
            $0.centerY.equalTo(checkBox)
        })
        
        timeButton.snp.makeConstraints({
            $0.right.left.equalToSuperview().inset(StaticSize.size(15))
            $0.bottom.equalToSuperview()
            $0.height.equalTo(StaticSize.size(36))
        })
        
        timeButton.addSubViews([rightArrow, timeTitle])
        
        rightArrow.snp.makeConstraints({
            $0.right.equalToSuperview().offset(-StaticSize.size(2))
            $0.centerY.equalToSuperview()
            $0.size.equalTo(StaticSize.size(32))
        })
        
        timeTitle.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.size(11))
            $0.centerY.equalToSuperview()
            $0.right.equalTo(rightArrow.snp.left).offset(StaticSize.size(-1.5))
        })
    }
    
    @objc func checkBoxTapped() {
        isActive.toggle()
    }
    
    @objc func timeTapped() {
        openTimeTable?(self)
    }
}
