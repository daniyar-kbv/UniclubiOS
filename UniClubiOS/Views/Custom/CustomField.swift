//
//  CustomField.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/9/20.
//

import Foundation
import UIKit
import SnapKit

class CustomField: UIView {
    var type: FormFieldType?
    var onChange: ((_ textField: UITextField)->())?
    var isValid: Bool {
        switch type {
        case .companyName, .firstName, .lastName:
            return !textField.isEmpty
        case .email:
            return textField.text?.isValidEmail() ?? false
        case .phone:
            return textField.text?.count == 16
        default:
            return false
        }
    }
    
    lazy var textField: UITextField = {
        let view = UITextField()
        view.font = .ptSans(ofSize: StaticSize.size(16), weight: .regular)
        view.textColor = .customDarkBlue
        view.adjustsFontSizeToFitWidth = true
        view.delegate = self
        view.addTarget(self, action: #selector(onFieldChange), for: .editingChanged)
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
        layer.borderWidth = StaticSize.size(0.5)
        layer.borderColor = UIColor.customLightGray.cgColor
        layer.cornerRadius = StaticSize.size(5)
        
        addSubViews([textField])
        
        textField.snp.makeConstraints({
            $0.left.right.equalToSuperview().inset(StaticSize.size(11))
            $0.centerY.equalToSuperview()
        })
    }
    
    @objc func onFieldChange(textField: UITextField) {
        onChange?(textField)
    }
}

extension CustomField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if type == .phone {
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            switch newString.count {
            case 0:
                break
            case 1:
                textField.text = "+7 7\(newString)"
            case 3, 2:
                textField.text = ""
            default:
                textField.text = newString.format()
            }
    //        nextButton.isActive = textField.text?.count == 16
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        AppShared.sharedInstance.editingField = textField
    }
}


