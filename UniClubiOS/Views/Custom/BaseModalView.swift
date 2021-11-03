//
//  BaseModalView.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/9/20.
//

import Foundation
import UIKit
import SnapKit

class BaseModalView: UIView {
    var withBar: Bool
    
    lazy var topBrush: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = StaticSize.size(2.5)
        return view
    }()
    
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
            addSubViews([topBrush, navigationBar, contentView]) :
            addSubViews([topBrush, contentView])
        
        topBrush.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(7))
            $0.height.equalTo(StaticSize.size(5))
            $0.width.equalTo(StaticSize.size(41))
            $0.centerX.equalToSuperview()
        })
        
        if withBar {
            navigationBar.snp.makeConstraints({
                $0.top.equalTo(topBrush.snp.bottom).offset(StaticSize.size(7))
                $0.left.right.equalToSuperview()
                $0.height.equalTo(StaticSize.size(44))
            })
        }
        
        contentView.snp.makeConstraints({
            withBar ?
                $0.top.equalTo(navigationBar.snp.bottom) :
                $0.top.equalTo(topBrush.snp.bottom).offset(StaticSize.size(7))
            $0.left.right.bottom.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
