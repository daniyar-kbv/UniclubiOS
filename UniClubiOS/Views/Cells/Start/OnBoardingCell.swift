//
//  OnBoardingCell.swift
//  GOALSTER
//
//  Created by Daniyar on 8/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Lottie

class OnBoardingCell: UICollectionViewCell {
    static let reuseIdentifier = "OnBoardingCell"
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = StaticSize.size(10)
        view.layer.masksToBounds = true
        return view
    }()
    
    var animationView: AnimationView?
    
    lazy var topText: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.textAlignment = .center
        view.font = .ptSans(ofSize: StaticSize.size(22), weight: .bold)
        view.textColor = .customDarkBlue
        return view
    }()
    
    lazy var bottomText: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.textAlignment = .center
        view.font = .ptSans(ofSize: StaticSize.size(16), weight: .regular)
        view.textColor = .customDarkBlue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        animationView?.removeFromSuperview()
    }
    
    func setUp() {
        addSubViews([backView])
        
        backView.snp.makeConstraints({
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        backView.addBackground()
        
        backView.addSubViews([topText, bottomText])
        
        topText.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(429))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        bottomText.snp.makeConstraints({
            $0.top.equalTo(topText.snp.bottom).offset(StaticSize.size(25))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
    }
}
