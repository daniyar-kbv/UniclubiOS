//
//  TimeControll.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/12/20.
//

import Foundation
import UIKit
import SnapKit

fileprivate class TimeButton: UIButton {
    var type: TimeTypes
    
    required init(type: TimeTypes) {
        self.type = type
        
        super.init(frame: .zero)
        
        setTitle(type.title, for: .normal)
        titleLabel?.font = .ptSans(ofSize: StaticSize.size(15), weight: .regular)
        layer.borderWidth = StaticSize.size(0.5)
        layer.borderColor = UIColor.customGreen.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func activate(_ activate: Bool = true) {
        setTitleColor(activate ? .white : .customGreen, for: .normal)
        backgroundColor = activate ? .customGreen : .customBackround
    }
}
 
class TimeControllView: UIStackView {
    lazy fileprivate var leftButton = TimeButton(type: .beforeLunch)
    lazy fileprivate var centerButton = TimeButton(type: .afterLunch)
    lazy fileprivate var rightButton = TimeButton(type: .allDay)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addArrangedSubViews([leftButton, centerButton, rightButton])
        
        axis = .horizontal
        distribution = .fillEqually
        alignment = .fill
        
        layer.cornerRadius = StaticSize.size(4)
        layer.borderWidth = StaticSize.size(1)
        layer.borderColor = UIColor.customGreen.cgColor
        layer.masksToBounds = true
        
        leftButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        centerButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        for view in arrangedSubviews as! [TimeButton]{
            view.activate(view.type == AppShared.sharedInstance.selectedFilters.timeType)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func buttonTapped(_ button: TimeButton) {
        var newFilters = AppShared.sharedInstance.selectedFilters
        newFilters.timeType = button.type
        AppShared.sharedInstance.selectedFilters = newFilters
        UIView.animate(withDuration: 0.2, animations: {
            for view in self.arrangedSubviews as! [TimeButton]{
                view.activate(view == button)
            }
        })
        
    }
}
