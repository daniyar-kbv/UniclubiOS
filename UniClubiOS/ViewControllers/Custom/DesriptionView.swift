//
//  DesriptionView.swift
//  UniClubiOS
//
//  Created by Daniyar on 13.12.2020.
//

import Foundation
import UIKit

class DescriptionView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(16), weight: .bold)
        label.textColor = .customDarkBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var text: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.font = .ptSans(ofSize: StaticSize.size(15), weight: .regular)
        view.textColor = .customDarkBlue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubViews([titleLabel, text])
        
        titleLabel.snp.makeConstraints({
            $0.top.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        text.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(StaticSize.size(5))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.bottom.equalToSuperview()
        })
    }
}
