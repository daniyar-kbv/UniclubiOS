//
//  FormViewController.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/9/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class FormViewController: BaseViewController {
    lazy var formView = FormView(withBar: true)
    lazy var viewModel = FormViewModel()
    lazy var disposeBag = DisposeBag()
        
    var type: FormType
    
    var name = ""
    var name2 = ""
    var email = ""
    var phone = ""
    
    required init(type: FormType) {
        self.type = type
        
        super.init(nibName: .none, bundle: .none)
        
        formView.type = type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = formView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formView.tableView.delegate = self
        formView.tableView.dataSource = self
        
        hideKeyboardWhenTappedAround()
        
        moveWindowOnKeyboard = true
        
        formView.bottomButton.addTarget(self, action: #selector(sendApplication), for: .touchUpInside)
        
        switch type {
        case .partner:
            break
        case .booking:
            formView.navigationBar.leftButton.addTarget(self, action: #selector(popTop), for: .touchUpInside)
        }
        
        bind()
    }
    
    func bind() {
        viewModel.partnershipResponse.subscribe(onNext: { response in
            DispatchQueue.main.async {
                self.showAlertOk(title: "Заявка успешно отправлена", okCompletion: { action in
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }).disposed(by: disposeBag)
        viewModel.bookingResponse.subscribe(onNext: { response in
            DispatchQueue.main.async {
                AppShared.sharedInstance.cart.clear()
                let vc = BookingSuccessViewController()
                vc.bookingResponse = response
                self.openTop(vc: vc, animated: false)
            }
        }).disposed(by: disposeBag)
    }
    
    func onFieldChange(textField: UITextField) {
        var count = formView.tableView.numberOfRows(inSection: 0)
        for i in 0..<formView.tableView.numberOfRows(inSection: 0) {
            let cell = formView.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! FormCell
            switch cell.field.type {
            case.firstName:
                name = cell.field.textField.text ?? ""
            case .companyName, .lastName:
                name2 = cell.field.textField.text ?? ""
            case .email:
                email = cell.field.textField.text ?? ""
            case .phone:
                phone = (cell.field.textField.text ?? "").replacingOccurrences(of: " ", with: "")
            default:
                break
            }
            if cell.field.isValid {
                count -= 1
            }
        }
        formView.bottomButton.isActive = count == 0
    }
    
    @objc func popTop() {
        removeTop()
    }
    
    @objc func sendApplication() {
        switch type {
        case .partner:
            viewModel.partnerApplicarion(name: name, company_name: name2, email: email, mobile_phone: phone)
        case .booking:
            viewModel.bookingApplication(first_name: name, last_name: name2, email: email, mobile_phone: phone)
        }
    }
}

extension FormViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FormCell.reuseIdentifier, for: indexPath) as! FormCell
        cell.field.onChange = onFieldChange(textField:)
        switch indexPath.row {
        case 0:
            cell.type = .firstName
        case 1:
            switch type {
            case .partner:
                cell.type = .companyName
            case .booking:
                cell.type = .lastName
            }
        case 2:
            cell.type = .phone
        case 3:
            cell.type = .email
        default:
            break
        }
        return cell
    }
}
