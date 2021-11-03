//
//  ScheduleTableView.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/16/20.
//

import Foundation
import UIKit

class ScheduleTableView: UITableView {
    var onTouch: (()->())?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self) else { return }
        onTouch?()
    }
}
