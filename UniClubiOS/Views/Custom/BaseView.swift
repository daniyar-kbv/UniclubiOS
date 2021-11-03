//
//  BaseView.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/10/20.
//

import Foundation
import UIKit
import SnapKit

class BaseView: UIView {
    var withBar: Bool
    
    lazy var navigationBar: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.isBottomLineHidden = true
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    required init(withBar: Bool = true) {
        self.withBar = withBar
        
        super.init(frame: .zero)
        
        withBar ?
            addSubViews([navigationBar, contentView]) :
            addSubViews([contentView])
        
        if withBar {
            navigationBar.snp.makeConstraints({
                $0.top.equalToSuperview().offset(Global.safeAreaTop())
                $0.left.right.equalToSuperview()
                $0.height.equalTo(StaticSize.size(44))
            })
        }
        
        contentView.snp.makeConstraints({
            withBar ?
                $0.top.equalTo(navigationBar.snp.bottom) :
                $0.top.equalToSuperview().offset(Global.safeAreaTop())
            $0.left.right.bottom.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
