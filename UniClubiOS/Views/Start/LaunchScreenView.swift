//
//  LaunchScreenView.swift
//  GOALSTER
//
//  Created by Daniyar on 8/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

class LaunchScreenView: UIView {
    
    lazy var logo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        addSubViews([logo])
        
        logo.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.width.equalTo(StaticSize.size(246))
            $0.height.equalTo(StaticSize.size(222))
        })
        
        addBackground()
    }
}
