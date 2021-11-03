//
//  FiltersMainView.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/9/20.
//

import Foundation
import SnapKit

class FiltersMainView: UIView {
    lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var navigationBar: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.setTitle("Фильтр")
        view.backgroundColor = .white
        view.setRightTitle("Очистить")
        view.leftButton.isHidden = true
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        view.register(FiltersMainCell.self, forCellReuseIdentifier: FiltersMainCell.reuseIdentifier)
        view.rowHeight = StaticSize.size(63)
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: StaticSize.size(150), right: 0)
        return view
    }()
    
    lazy var reminderButton: ReminderButton = {
        let view = ReminderButton()
        return view
    }()
    
    lazy var bottomButton: UIButton = {
        let view = UIButton()
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Если Вы владелец клуба, становитесь нашим Партнером!", attributes: underlineAttribute)
        view.setAttributedTitle(underlineAttributedString, for: .normal)
        view.setTitleColor(.customGreen, for: .normal)
        view.titleLabel?.font = .ptSans(ofSize: StaticSize.size(18), weight: .bold)
        view.titleLabel?.lineBreakMode = .byWordWrapping
        view.titleLabel?.textAlignment = .center
        return view
    }()
    
    lazy var showButton: CustomButton = {
        let view = CustomButton()
        view.setTitle("Показать занятия", for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addBackground()
        
        addSubViews([whiteView, navigationBar, tableView, showButton, bottomButton, reminderButton])
        
        whiteView.snp.makeConstraints({
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(Global.safeAreaTop())
        })
        
        navigationBar.snp.makeConstraints({
            $0.top.equalTo(whiteView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(StaticSize.size(44))
        })
        
        tableView.snp.makeConstraints({
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        })
        
        showButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
        })
        
        bottomButton.snp.makeConstraints({
            $0.bottom.equalTo(showButton.snp.top).offset(-StaticSize.size(29))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        reminderButton.snp.makeConstraints({
            $0.bottom.equalTo(bottomButton.snp.top).offset(-StaticSize.size(130))
            $0.centerX.equalToSuperview()
            $0.size.equalTo(StaticSize.size(70))
        })
    }
}
