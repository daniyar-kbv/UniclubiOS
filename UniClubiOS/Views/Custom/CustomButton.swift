//
//  CustomButton.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import StoreKit

class CustomButton: UIButton {
    var backgroundImage: UIImage
    var isActive: Bool = true {
        didSet {
            setBackgroundImage(backgroundImage.alpha(isActive ? 1 : 0.5), for: .normal)
            isUserInteractionEnabled = isActive
        }
    }
    
    required init(backgroundImage: UIImage = UIImage(named: "buttonBack")!) {
        self.backgroundImage = backgroundImage
        
        super.init(frame: .zero)
        
        setBackgroundImage(backgroundImage, for: .normal)
        titleLabel?.font = .ptSans(ofSize: StaticSize.size(20), weight: .regular)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomButtonTwoText: CustomButton {
    lazy var leftTitle: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: StaticSize.size(16), weight: .bold)
        view.textColor = .white
        return view
    }()
    
    lazy var rightTitle: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: StaticSize.size(16), weight: .bold)
        view.textColor = .white
        return view
    }()
    
    required init(backgroundImage: UIImage = UIImage(named: "buttonBack")!) {
        super.init(backgroundImage: backgroundImage)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        addSubViews([leftTitle, rightTitle])
        
        leftTitle.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.size(20))
            $0.centerY.equalToSuperview()
        })
        
        rightTitle.snp.makeConstraints({
            $0.right.equalToSuperview().offset(-StaticSize.size(20))
            $0.centerY.equalToSuperview()
        })
    }
    
    func setLeftTitle(text: String) {
        leftTitle.text = text
    }
    
    func setRightTitle(text: String) {
        rightTitle.text = text
    }
}

class ProductButton: CustomButton {
    var product: SKProduct
    
    required init(product: SKProduct) {
        self.product = product
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(backgroundImage: UIImage = UIImage(named: "buttonBack")!) {
        fatalError("init(backgroundImage:) has not been implemented")
    }
}
