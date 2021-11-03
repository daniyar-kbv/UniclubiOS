//
//  NavigationBar.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/9/20.
//

import Foundation
import SnapKit

class CustomNavigationBar: UIView {
    var isTitleHidden: Bool = false {
        didSet {
            titleLabel.isHidden = isTitleHidden
        }
    }
    
    var isBottomLineHidden: Bool = false {
        didSet {
            bottomLine.isHidden = isBottomLineHidden
        }
    }
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(18), weight: .bold)
        label.textColor = .customDarkBlue
        return label
    }()
    
    lazy var leftButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "arrowLeft"), for: .normal)
        view.addTarget(self, action: #selector(onBack), for: .touchUpInside)
        return view
    }()
    
    lazy var rightButton: UIButton = {
        let view = UIButton()
        view.setTitleColor(.customLightBlue, for: .normal)
        view.titleLabel?.font = .ptSans(ofSize: StaticSize.size(16), weight: .regular)
        return view
    }()
    
    lazy private var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
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
        addSubViews([leftButton, titleLabel, rightButton, bottomLine])
        
        leftButton.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.size(18))
            $0.size.equalTo(StaticSize.size(25))
            $0.centerY.equalToSuperview()
        })
        
        titleLabel.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
        
        rightButton.snp.makeConstraints({
            $0.right.equalToSuperview().offset(-StaticSize.size(18))
            $0.centerY.equalToSuperview()
        })
        
        bottomLine.snp.makeConstraints({
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(StaticSize.size(1))
        })
    }
    
    func setRightTitle(_ title: String) {
        rightButton.setTitle(title, for: .normal)
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    @objc private func onBack() {
        if viewContainingController()?.isModal ?? false {
            viewContainingController()?.dismiss(animated: true, completion: nil)
        } else {
            viewContainingController()?.navigationController?.popViewController(animated: true)
        }
    }
}
