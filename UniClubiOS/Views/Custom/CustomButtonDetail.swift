//
//  CustomButtonDetail.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/15/20.
//

import Foundation
import UIKit
import SnapKit

class CustomButtonDetail: UIButton {
    lazy var leftImage: UIImageView = {
        let view = UIImageView()
        view.tintColor = .customDarkBlue
        return view
    }()
    
    lazy var rightImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrowRight")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .customLightGray
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(16), weight: .bold)
        label.textColor = .customDarkBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var subtitle: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(14), weight: .regular)
        label.textColor = .customGreen
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var titleStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [title, subtitle])
        view.axis = .vertical
        view.distribution = .equalCentering
        view.alignment = .fill
        return view
    }()
    
    lazy var stack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [leftImage, titleStack])
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.alignment = .center
        view.spacing = StaticSize.size(10)
        view.isUserInteractionEnabled = false
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
        addSubViews([rightImage, stack])
        
        rightImage.snp.makeConstraints({
            $0.right.equalToSuperview().offset(StaticSize.size(-21))
            $0.centerY.equalToSuperview()
            $0.size.equalTo(StaticSize.size(20))
        })
        
        stack.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.size(15))
            $0.top.bottom.equalToSuperview()
            $0.right.equalTo(rightImage.snp.left).offset(StaticSize.size(-15))
        })
    }
}
