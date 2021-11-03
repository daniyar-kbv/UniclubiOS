//
//  ScheduleView.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/15/20.
//

import Foundation
import UIKit
import SnapKit

class ScheduleView: BaseModalView {
    var onTouch: (()->())? {
        didSet {
            tableView.onTouch = onTouch
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(22), weight: .bold)
        label.textColor = .customDarkBlue
        label.text = "Выберите время посещения"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        return view
    }()
    
    lazy var tableView: ScheduleTableView = {
        let view = ScheduleTableView()
        view.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.reuseIdentifier)
        view.rowHeight = StaticSize.size(96)
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: StaticSize.size(Global.safeAreaBottom() + StaticSize.buttonHeight + StaticSize.size(30)), right: 0)
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        return view
    }()
    
    lazy var button: CustomButton = {
        let view = CustomButton()
        view.setTitle("Применить", for: .normal)
        view.isActive = false
        return view
    }()
    
    required init(withBar: Bool = true) {
        super.init(withBar: withBar)
        
        backgroundColor = .white
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self) else { return }
        onTouch?()
    }
    
    func setUp() {
        contentView.addSubViews([titleLabel, line, tableView, button])
        
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(35))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        line.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(StaticSize.size(11))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.size(1))
        })
        
        tableView.snp.makeConstraints({
            $0.top.equalTo(line.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        })
        
        button.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
        })
    }
}
