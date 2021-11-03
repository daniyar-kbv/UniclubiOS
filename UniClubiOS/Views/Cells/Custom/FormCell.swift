//
//  CustomFormCell.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/9/20.
//

import Foundation
import UIKit
import SnapKit

class FormCell: UITableViewCell {
    static let reuseIdentifier = "FormCell"
    
    var type: FormFieldType? {
        didSet {
            titleLabel.text = type?.title
            field.textField.placeholder = type?.placeholer
            field.textField.keyboardType = type?.keyboardType ?? .default
            field.type = type
            if type == .email{
                field.textField.autocapitalizationType = .none
            }
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(12), weight: .regular)
        label.textColor = .customDarkBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var field: CustomField = {
        let view = CustomField()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        selectionStyle = .none
        
        contentView.addSubViews([titleLabel, field])
        
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(16))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        field.snp.makeConstraints({
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.top.equalTo(titleLabel.snp.bottom).offset(StaticSize.size(6))
            $0.bottom.equalToSuperview()
        })
    }
}
