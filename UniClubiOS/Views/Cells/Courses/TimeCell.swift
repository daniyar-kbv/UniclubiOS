//
//  TimeCell.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/16/20.
//

import Foundation
import UIKit
import SnapKit

class TimeCell: UITableViewCell {
    static let reuseIdentifier = "TimeCell"
    
    var time: LessonTime? {
        didSet {
            title.text = "\(time?.fromTime?.getRange(end: 5) ?? "") - \(time?.toTime?.getRange(end: 5) ?? "")"
        }
    }
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(16), weight: .regular)
        label.textColor = .customDarkBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([title])
        
        title.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.size(15))
            $0.centerY.equalToSuperview()
        })
    }
}
