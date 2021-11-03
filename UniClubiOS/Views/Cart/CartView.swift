//
//  CartView.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/16/20.
//

import Foundation
import UIKit
import SnapKit

class CartView: BaseModalView {
    lazy var topLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseIdentifier)
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Global.safeAreaBottom() + StaticSize.buttonHeight + StaticSize.size(30), right: 0)
        view.rowHeight = StaticSize.size(120)
        view.separatorStyle = .none
        return view
    }()
    
    lazy var bottomButton: CustomButton = {
        let view = CustomButton()
        view.setTitle("Отправить заявку", for: .normal)
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
    
    func setUp() {
        contentView.addSubViews([tableView, topLine, bottomButton])
        
        topLine.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.size(1))
        })
        
        tableView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        bottomButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
        })
    }
}
