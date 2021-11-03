//
//  CartViewController.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/16/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class CartViewController: UIViewController {
    lazy var cartView = CartView()
    lazy var disposeBag = DisposeBag()
    var cart: Cart = AppShared.sharedInstance.cart {
        didSet {
            cartView.tableView.reloadSections(IndexSet([0]), with: .automatic)
            if cart.items?.count == 0 && !children.contains(where: { $0 is FormViewController }) {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = cartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartView.navigationBar.setTitle("Корзина")
        
        cartView.tableView.delegate = self
        cartView.tableView.dataSource = self
        
        cartView.bottomButton.addTarget(self, action: #selector(showForm), for: .touchUpInside)
        
        bind()
    }
    
    func bind() {
        AppShared.sharedInstance.cartSubject.subscribe(onNext: { cart in
            DispatchQueue.main.async {
                self.cart = cart
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func showForm() {
        let vc = FormViewController(type: .booking)
        openTop(vc: vc)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseIdentifier, for: indexPath) as! CartCell
        cell.cartItem = cart.items?[indexPath.row]
        return cell
    }
}
