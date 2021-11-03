//
//  BookingSuccessViewController.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/17/20.
//

import Foundation
import UIKit

class BookingSuccessViewController: UIViewController {
    lazy var successView = BookingSuccessView(withBar: false)
    var bookingResponse: BookingApplicationResponse? {
        didSet {
            if let id = bookingResponse?.id {
                successView.text.text = "Ваша заявка #\(id) принята и находится в обработке. Мы свяжемся со всеми клубами, чтобы подтвердить вашу запись, и перезвоним Вам в ближайшее время. Спасибо за обращение."
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = successView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        successView.bottomButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        successView.animationView.play()
    }
    
    @objc func close() {
        parent?.parent?.dismiss(animated: true, completion: nil)
    }
}
