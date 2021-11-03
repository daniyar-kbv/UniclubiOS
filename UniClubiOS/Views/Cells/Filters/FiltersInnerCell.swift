//
//  FiltersInnerCell.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/10/20.
//

import Foundation
import UIKit
import SnapKit

class FiltersInnerCell: UITableViewCell {
    static let reuseIdentifier = "FiltersInnerCell"
    
    var type: FilterType?
    
    var isActive = false {
        didSet {
            checkBox.image = isActive ? UIImage(named: "checkBoxOn") : UIImage(named: "checkBoxOff")
        }
    }
    
    var item: Properties? {
        didSet {
            switch type {
            case .ageGroup:
                guard let item = item as? AgeGroup, let id = item.id else {
                    return
                }
                setTitle(title: "\(item.fromAge ?? 0) - \(item.toAge ?? 0)")
                isActive = AppShared.sharedInstance.selectedFilters.ageGroups.contains(id)
            case .attendanceType:
                guard let item = item as? AttendanceType, let id = item.id else {
                    return
                }
                setTitle(title: item.name ?? "")
                isActive = AppShared.sharedInstance.selectedFilters.attendanceTypes.contains(id)
            case .administrativeDivision:
                guard let item = item as? AdministrativeDivision, let id = item.id else {
                    return
                }
                setTitle(title: item.name ?? "")
                isActive = AppShared.sharedInstance.selectedFilters.administrativeDivisions.contains(id)
            case .lessonGroup:
                guard let item = item as? LessonGroup, let id = item.id else {
                    return
                }
                setTitle(title: item.name ?? "")
                isActive = AppShared.sharedInstance.selectedFilters.lessonGroups.contains(id)
            case .lessonType:
                guard let item = item as? LessonType, let id = item.id else {
                    return
                }
                setTitle(title: item.name ?? "")
                isActive = AppShared.sharedInstance.selectedFilters.lessonTypes.contains(id)
            default:
                break
            }
        }
    }
    
    var superVc: FiltersInnerViewController?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(16), weight: .bold)
        label.textColor = .customDarkBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var checkBox: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "checkBoxOff")
        return view
    }()
    
    lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    @objc func onCellTap() {
        isActive.toggle()
        switch type {
        case .ageGroup:
            guard let item = item as? AgeGroup, let id = item.id else {
                return
            }
            if !isActive {
                if let index = superVc?.selectedFilters.ageGroups.firstIndex(of: id) {
                    superVc?.selectedFilters.ageGroups.remove(at: index)
                }
            } else {
                superVc?.selectedFilters.ageGroups.append(id)
            }
        case .attendanceType:
            guard let item = item as? AttendanceType, let id = item.id else {
                return
            }
            if !isActive {
                if let index = superVc?.selectedFilters.attendanceTypes.firstIndex(of: id) {
                    superVc?.selectedFilters.attendanceTypes.remove(at: index)
                }
            } else {
                superVc?.selectedFilters.attendanceTypes.append(id)
            }
        case .administrativeDivision:
            guard let item = item as? AdministrativeDivision, let id = item.id else {
                return
            }
            if !isActive {
                if let index = superVc?.selectedFilters.administrativeDivisions.firstIndex(of: id) {
                    superVc?.selectedFilters.administrativeDivisions.remove(at: index)
                }
            } else {
                superVc?.selectedFilters.administrativeDivisions.append(id)
            }
        case .lessonGroup:
            guard let item = item as? LessonGroup, let id = item.id else {
                return
            }
            if !isActive {
                if let index = superVc?.selectedFilters.lessonGroups.firstIndex(of: id) {
                    superVc?.selectedFilters.lessonGroups.remove(at: index)
                }
            } else {
                superVc?.selectedFilters.lessonGroups.append(id)
            }
        case .lessonType:
            guard let item = item as? LessonType, let id = item.id else {
                return
            }
            if !isActive {
                if let index = superVc?.selectedFilters.lessonTypes.firstIndex(of: id) {
                    superVc?.selectedFilters.lessonTypes.remove(at: index)
                }
            } else {
                superVc?.selectedFilters.lessonTypes.append(id)
            }
        default:
            break
        }
    }
    
    func setUp() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(onCellTap))
        )
        
        addSubViews([checkBox, titleLabel, bottomLine])
        
        checkBox.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-StaticSize.size(22))
            $0.size.equalTo(StaticSize.size(32))
        })
        
        titleLabel.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.size(15))
            $0.right.equalTo(checkBox.snp.left).offset(-StaticSize.size(10))
            $0.centerY.equalToSuperview()
        })
        
        bottomLine.snp.makeConstraints({
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.bottom.equalToSuperview()
            $0.height.equalTo(StaticSize.size(1))
        })
    }
}
