//
//  FormView.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/9/20.
//

import Foundation
import UIKit
import SnapKit

class FormView: BaseModalView {
    var type: FormType? {
        didSet {
            navigationBar.setTitle(type?.title ?? "")
        }
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(FormCell.self, forCellReuseIdentifier: FormCell.reuseIdentifier)
        view.rowHeight = StaticSize.size(70)
        view.separatorStyle = .none
        view.isScrollEnabled = false
        view.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: Global.safeAreaBottom() + StaticSize.size(50),
            right: 0
        )
        return view
    }()
    
    lazy var bottomButton: CustomButton = {
        let view = CustomButton()
        view.setTitle("Отправить заявку", for: .normal)
        view.isActive = false
        return view
    }()
    
    required init(withBar: Bool = true) {
        super.init(withBar: withBar)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        backgroundColor = .white
        
        contentView.addSubViews([tableView, bottomButton])
        
        tableView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.right.bottom.equalToSuperview()
        })
        
        bottomButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
            $0.height.equalTo(StaticSize.buttonHeight)
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
    }
}
