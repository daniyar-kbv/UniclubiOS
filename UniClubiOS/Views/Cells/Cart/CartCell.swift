//
//  CartCell.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/16/20.
//

import Foundation
import UIKit
import SnapKit

class CartCell: UITableViewCell {
    static let reuseIdentifier = "CartCell"
    
    var cartItem: CartItem? {
        didSet {
            mainImage.kf.setImage(with: URL(string: cartItem?.image ?? ""))
            timeTitle.text = "\(cartItem?.time?.fromTime?.getRange(end: 5) ?? "") - \(cartItem?.time?.toTime?.getRange(end: 5) ?? "")"
            courseName.text = cartItem?.name
        }
    }
    
    lazy var mainImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var timeTitle: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(16), weight: .regular)
        label.textColor = .customLightGray
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "closeBlue"), for: .normal)
        view.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        return view
    }()
    
    lazy var courseName: CustomLabelWithoutPadding = {
        let label = CustomLabelWithoutPadding()
        label.font = .ptSans(ofSize: StaticSize.size(22), weight: .bold)
        label.textColor = .customDarkBlue
        return label
    }()
    
    lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func deleteTapped() {
        if let cartItem = cartItem {
            AppShared.sharedInstance.cart.remove(cartItem: cartItem)
        }
    }
    
    func setUp() {
        contentView.addSubViews([mainImage, timeTitle, courseName, closeButton, bottomLine])
        
        mainImage.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(StaticSize.size(15))
            $0.width.equalTo(StaticSize.size(100))
            $0.height.equalTo(StaticSize.size(96))
        })
        
        timeTitle.snp.makeConstraints({
            $0.top.equalTo(mainImage)
            $0.left.equalTo(mainImage.snp.right).offset(StaticSize.size(8))
        })
        
        courseName.snp.makeConstraints({
            $0.top.equalTo(timeTitle.snp.bottom).offset(StaticSize.size(6))
            $0.left.equalTo(timeTitle)
            $0.right.equalToSuperview().offset(-StaticSize.size(15))
            $0.bottom.equalTo(mainImage)
        })
        
        closeButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(4))
            $0.right.equalToSuperview().offset(-StaticSize.size(15))
            $0.size.equalTo(StaticSize.size(32))
        })
        
        bottomLine.snp.makeConstraints({
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.size(1))
        })
    }
}
