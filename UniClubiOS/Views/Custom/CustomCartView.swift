//
//  CustomCartView.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/16/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class CustomCartView: UIView {
    lazy var disposeBag = DisposeBag()
    
    lazy var button: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = StaticSize.size(10)
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(openCart), for: .touchUpInside)
        return view
    }()

    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(20), weight: .bold)
        label.textColor = .white
        label.text = AppShared.sharedInstance.cart.title
        return label
    }()
    
    lazy var cartButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.layer.cornerRadius = StaticSize.size(10)
        view.setTitle("Корзина", for: .normal)
        view.setTitleColor(.customDarkBlue, for: .normal)
        view.titleLabel?.font = .ptSans(ofSize: StaticSize.size(14), weight: .bold)
        view.isUserInteractionEnabled = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 6.0
        
        setUp()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        button.addGradientBackground()
    }
    
    func bind(){
        AppShared.sharedInstance.cartSubject.subscribe(onNext: {cart in
            self.setText(text: cart.title)
            self.show(cart.items?.count ?? 0 > 0)
        }).disposed(by: disposeBag)
    }
    
    func setUp(){
        addSubViews([button])
        
        button.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(11))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
        })
        
        button.addSubViews([cartButton, title])
        
        cartButton.snp.makeConstraints({
            $0.right.top.bottom.equalToSuperview().inset(StaticSize.size(9))
            $0.width.equalTo(StaticSize.size(82))
        })
        
        title.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.size(17))
            $0.right.equalTo(cartButton.snp.left).offset(-StaticSize.size(17))
            $0.centerY.equalToSuperview()
        })
    }
    
    func setText(text: String){
        title.text = text
    }
    
    @objc func openCart(){
        if let vc = viewContainingController(){
            vc.present(CartViewController(), animated: true, completion: nil)
        }
    }
    
    func show(_ show: Bool){
        guard let superview = self.superview else { return }
        self.isHidden = !show
        self.snp.updateConstraints({
            $0.height.equalTo(
                show ?
                    Global.safeAreaBottom() + StaticSize.size(22) + StaticSize.buttonHeight :
                    0
            )
        })
        UIView.animate(withDuration: 0.3, animations: {
            superview.layoutIfNeeded()
        })
    }
}
