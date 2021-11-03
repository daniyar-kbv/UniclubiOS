//
//  FiletersInnerView.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/10/20.
//

import Foundation
import UIKit

class FiltersInnerView: BaseView {
    var withSearchField: Bool
    
    lazy var searchField: SearchField = {
        let view = SearchField()
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = StaticSize.size(63)
        view.register(FiltersInnerCell.self, forCellReuseIdentifier: FiltersInnerCell.reuseIdentifier)
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: withSearchField ? StaticSize.size(28) : 0, left: 0, bottom: Global.safeAreaBottom() + StaticSize.size(80), right: 0)
        return view
    }()
    
    lazy var bottomButton: CustomButton = {
        let view = CustomButton()
        view.setTitle("Применить", for: .normal)
        return view
    }()
    
    required init(withBar: Bool = true, withSearchField: Bool = false) {
        self.withSearchField = withSearchField
        
        super.init(withBar: withBar)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(withBar: Bool = true) {
        fatalError("init(withBar:) has not been implemented")
    }
    
    func setUp() {
        backgroundColor = .white
        
        withSearchField ?
            contentView.addSubViews([tableView, searchField, bottomButton]) :
            contentView.addSubViews([tableView, bottomButton])
        
        contentView.addBackground()
        
        tableView.snp.makeConstraints({
            withSearchField ?
                $0.top.equalToSuperview().offset(StaticSize.size(28)) :
                $0.top.equalToSuperview()
            $0.left.right.bottom.equalToSuperview()
        })
        
        if withSearchField {
            searchField.snp.makeConstraints({
                $0.top.equalToSuperview().offset(StaticSize.size(10))
                $0.left.right.equalToSuperview().inset(StaticSize.size(15))
                $0.height.equalTo(StaticSize.size(36))
            })
        }
        
        bottomButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
        })
    }
}
