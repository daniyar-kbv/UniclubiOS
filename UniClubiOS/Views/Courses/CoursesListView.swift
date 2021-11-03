//
//  CoursesListView.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/12/20.
//

import Foundation
import UIKit
import SnapKit
import Lottie

class CoursesListView: UIView {
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .customBackround
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 6.0
        return view
    }()
    
    lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customGreen
        return view
    }()
    
    lazy var filtersButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "filters"), for: .normal)
        view.setTitle("Фильтр", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .ptSans(ofSize: StaticSize.size(16), weight: .regular)
        view.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.backgroundColor = .customGreen
        view.layer.cornerRadius = StaticSize.size(10)
        view.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: StaticSize.size(5))
        view.titleEdgeInsets = UIEdgeInsets(top: 0, left: StaticSize.size(5), bottom: 0, right: 0)
        return view
    }()
    
    lazy var timeControllView = TimeControllView()
    
    lazy var reminderView = ReminderButton()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = StaticSize.size(272)
        view.register(CoursesListCell.self, forCellReuseIdentifier: CoursesListCell.reuseIdentifier)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        view.contentInset = UIEdgeInsets(top: StaticSize.size(8), left: 0, bottom: StaticSize.size(100), right: 0)
        return view
    }()
    
    lazy var cartView: CustomCartView = {
        let view = CustomCartView()
        view.isHidden = !(AppShared.sharedInstance.cart.items?.count ?? 0 > 0)
        return view
    }()
    
    lazy var noCoursesAnimationView: AnimationView = {
        let view = AnimationView(name: "not_found")
        return view
    }()
    
    lazy var noCoursesText: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.text = "К сожалению мы не нашли занятий по Вашим параметрам, попробуйте изменить настройки Фильтра"
        view.font = .ptSans(ofSize: StaticSize.size(18), weight: .regular)
        view.textColor = .customDarkBlue
        view.textAlignment = .center
        return view
    }()
    
    lazy var noCoursesButton: CustomButton = {
        let view = CustomButton()
        view.setTitle("Вернуться в Фильтр", for: .normal)
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
        backgroundColor = .customBackround
        
        addSubViews([tableView, container, cartView])
        
        container.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(StaticSize.size(91) + Global.safeAreaTop())
        })
        
        container.addSubViews([filtersButton, timeControllView, reminderView])
        
        filtersButton.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(Global.safeAreaTop())
            $0.width.equalTo(StaticSize.size(113))
            $0.height.equalTo(StaticSize.size(36))
        })
        
        timeControllView.snp.makeConstraints({
            $0.top.equalTo(filtersButton.snp.bottom).offset(StaticSize.size(13))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.size(34))
        })
        
        reminderView.snp.makeConstraints({
            $0.top.equalTo(filtersButton).offset(StaticSize.size(-3))
            $0.left.equalToSuperview()
            $0.size.equalTo(StaticSize.size(70))
        })
        
        tableView.snp.makeConstraints({
            $0.top.equalTo(container.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        })
        
        cartView.snp.makeConstraints({
            $0.left.right.equalToSuperview()
            $0.height.equalTo(
                AppShared.sharedInstance.cart.items?.count ?? 0 > 0 ?
                    Global.safeAreaBottom() + StaticSize.size(22) + StaticSize.buttonHeight :
                    0
            )
            $0.bottom.equalToSuperview()
        })
    }
    
    func showNoCourses(_ show: Bool) {
        if show {
            for view in [noCoursesAnimationView, noCoursesText, noCoursesButton]{
                insertSubview(view, belowSubview: cartView)
            }
            
            noCoursesAnimationView.snp.makeConstraints({
                $0.top.equalTo(container.snp.bottom).offset(StaticSize.size(94))
                $0.centerX.equalToSuperview()
                $0.size.equalTo(StaticSize.size(250))
            })
            
            noCoursesText.snp.makeConstraints({
                $0.top.equalTo(noCoursesAnimationView.snp.bottom).offset(StaticSize.size(32))
                $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            })
            
            noCoursesButton.snp.makeConstraints({
                $0.top.equalTo(noCoursesText.snp.bottom).offset(StaticSize.size(24))
                $0.left.right.equalToSuperview().inset(StaticSize.size(15))
                $0.height.equalTo(StaticSize.buttonHeight)
            })
            
            noCoursesAnimationView.play()
        } else {
            for view in [noCoursesAnimationView, noCoursesText, noCoursesButton]{
                view.removeFromSuperview()
            }
        }
    }
    
    @objc func back() {
        self.viewContainingController()?.navigationController?.popViewController(animated: true)
    }
}
