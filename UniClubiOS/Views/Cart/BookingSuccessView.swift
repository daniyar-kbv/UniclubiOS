//
//  BookingSuccessView.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/17/20.
//

import Foundation
import UIKit
import SnapKit
import Lottie

class BookingSuccessView: BaseModalView {
    lazy var animationView: AnimationView = {
        let view = AnimationView(name: "success")
        return view
    }()
    
    lazy var text: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.text = "Текст об подтверждении успешной отправки заявки"
        view.font = .ptSans(ofSize: StaticSize.size(22), weight: .bold)
        view.textColor = .customDarkBlue
        view.textAlignment = .center
        return view
    }()
    
    lazy var bottomButton: CustomButton = {
        let view = CustomButton()
        view.setTitle("Вернуться на Главную", for: .normal)
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
        contentView.addSubViews([animationView, text, bottomButton])
        
        animationView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(133))
            $0.centerX.equalToSuperview()
            $0.size.equalTo(StaticSize.size(250))
        })
        
        text.snp.makeConstraints({
            $0.top.equalTo(animationView.snp.bottom).offset(StaticSize.size(40))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        bottomButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
        })
    }
}
