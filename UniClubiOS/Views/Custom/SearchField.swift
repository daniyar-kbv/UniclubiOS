//
//  SearchField.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/10/20.
//

import Foundation
import UIKit

class SearchField: UIView {
    var onChange: ((_ text: String)->())?
    
    lazy var searchImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "search")
        return view
    }()
    
    lazy var field: UITextField = {
        let view = UITextField()
        view.font = .ptSans(ofSize: StaticSize.size(16), weight: .regular)
        view.textColor = .customDarkBlue
        view.placeholder = "Поиск"
        view.adjustsFontSizeToFitWidth = true
        view.addTarget(self, action: #selector(onFieldChange(textField:)), for: .editingChanged)
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
        layer.borderColor = UIColor.customLightGray.cgColor
        layer.borderWidth = StaticSize.size(1)
        layer.cornerRadius = StaticSize.size(10)
        
        backgroundColor = .white
        
        addSubViews([searchImage, field])
        
        searchImage.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.size(10))
            $0.centerY.equalToSuperview()
            $0.size.equalTo(StaticSize.size(14))
        })
        
        field.snp.makeConstraints({
            $0.left.equalTo(searchImage.snp.right).offset(StaticSize.size(7))
            $0.right.equalToSuperview().offset(-StaticSize.size(7))
            $0.centerY.equalToSuperview()
        })
    }
    
    @objc func onFieldChange(textField: UITextField) {
        onChange?(textField.text ?? "")
    }
}
