//
//  ReminderView.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/12/20.
//

import Foundation
import UIKit
import SnapKit

class ReminderView: UIView {
    
    lazy var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = StaticSize.size(10)
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var background: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "close"), for: .normal)
        return view
    }()
    
    lazy var reminderImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "reminder")
        return view
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(22), weight: .bold)
        label.textColor = .customDarkBlue
        label.text = "Я тут чтобы напомнить =)"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var subtitle: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(16), weight: .regular)
        label.textColor = .customDarkBlue
        label.text = "Нажми на меня и подсказка снова появится"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var text: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.font = .ptSans(ofSize: StaticSize.size(16), weight: .regular)
        view.textColor = .customDarkBlue
        var attrBold = [
            NSAttributedString.Key.font: UIFont.ptSans(ofSize: StaticSize.size(13), weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue
        ]
        var attrRegular = [
            NSAttributedString.Key.font : UIFont.ptSans(ofSize: StaticSize.size(13), weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue
        ]
        var uniPassNameString = NSMutableAttributedString(string: "UniPass", attributes: attrBold)
        var uniPassString = NSMutableAttributedString(string: "– это единый абонемент во все клубы на разные занятия. Вы составляете расписание с удобным количеством посещений в месяц на разные занятия. Мы связываемся со всеми клубами и бронируем места, перезваниваем вам и подтверждаем вашу запись на выбранные вами занитя, после этого производится оплата.\n", attributes: attrRegular)
        var uniClassNameString = NSMutableAttributedString(string: "UniClass", attributes: attrBold)
        var uniClassString = NSMutableAttributedString(string: """
            – абонемент одного клуба на один вид занятий. Выбирайте расписание и оставляйте заявку через приложение. Мы связываемся с клубом и бронируем место для вашего ребенка, перезваниваем вам и подтверждаем вашу запись, далее производится оплата. Цена абонемента такая же как и в клубе. Покупая у нас более 2 х месяцев подряд, вы начинаете накапливать бонусы, которые сможете потратить на следующий абонемент. Размер бонуса зависит от вида занятий и клуба.
             Стоимость UniPass:  10 посещений – 20 000 тг; 20 посещений – 30 000 тг; 30 посещений – 50 000 тг

            Стоимость UniClass такая же как и в клубах. 
            Ваш абонемент с расписанием приходит на вашу почту. Для доступа к выбранным занятиям - нужно всего лишь предъявить номер абонемента на ресепшене клуба.
            """, attributes: attrRegular)

        uniPassNameString.append(uniPassString)
        uniPassNameString.append(uniClassNameString)
        uniPassNameString.append(uniClassString)
        view.attributedText = uniPassNameString
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0)
        
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self) else { return }
        if !container.frame.contains(location) {
            close()
        }
    }
    
    func setUp() {
        addSubViews([container])
        
        container.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(-ScreenSize.SCREEN_WIDTH)
            $0.width.equalTo(ScreenSize.SCREEN_WIDTH - StaticSize.size(30))
        })
        
        container.addSubViews([background, closeButton, reminderImage, title, subtitle, text])
        
        background.snp.makeConstraints({
            $0.edges.equalToSuperview().priority(.low)
        })
        
        closeButton.snp.makeConstraints({
            $0.top.right.equalToSuperview().inset(StaticSize.size(10))
            $0.size.equalTo(StaticSize.size(30))
        })
        
        reminderImage.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(17))
            $0.centerX.equalToSuperview()
            $0.size.equalTo(StaticSize.size(70))
        })
        
        title.snp.makeConstraints({
            $0.top.equalTo(reminderImage.snp.bottom).offset(StaticSize.size(8))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        subtitle.snp.makeConstraints({
            $0.top.equalTo(title.snp.bottom).offset(StaticSize.size(4))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        text.snp.makeConstraints({
            $0.top.equalTo(subtitle.snp.bottom).offset(StaticSize.size(12))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.bottom.equalToSuperview().offset(-StaticSize.size(23))
        })
    }
    
    static func showReminer(_ view: UIView) {
        let reminderView = self.init()
        
        view.addSubview(reminderView)
        
        reminderView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        view.layoutIfNeeded()
        
        reminderView.container.snp.updateConstraints({
            $0.centerX.equalToSuperview()
        })
        
        UIView.animate(withDuration: 0.5, animations: {
            view.layoutIfNeeded()
            reminderView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        })
    }
    
    @objc func close() {
        container.snp.updateConstraints({
            $0.centerX.equalToSuperview().offset(ScreenSize.SCREEN_WIDTH)
        })
        
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.superview?.layoutIfNeeded()
                self.backgroundColor = .clear
            },
            completion: { finished in
                self.removeFromSuperview()
            }
        )
    }
}


class ReminderButton: UIButton {
    var view: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setBackgroundImage(UIImage(named: "reminder"), for: .normal)
        
        addTarget(self, action: #selector(openReminder), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func openReminder() {
        if let view = view {
            ReminderView.showReminer(view)
        } else if let view = UIApplication.topViewController()?.view {
            ReminderView.showReminer(view)
        }
    }
}
