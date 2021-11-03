//
//  BaseViewController.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/9/20.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    var moveWindowOnKeyboard: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc override func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, moveWindowOnKeyboard {
            if (ScreenSize.SCREEN_HEIGHT - (AppShared.sharedInstance.editingField?.globalFrame?.maxY ?? 0)) < (keyboardSize.height + StaticSize.size(50)) {
                self.view.frame.origin.y += (ScreenSize.SCREEN_HEIGHT - (AppShared.sharedInstance.editingField?.globalFrame?.maxY ?? 0)) - (keyboardSize.height + StaticSize.size(50))
            }
        }
    }

    @objc override func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}
