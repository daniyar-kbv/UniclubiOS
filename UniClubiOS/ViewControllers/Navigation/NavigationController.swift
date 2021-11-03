//
//  NavigationController.swift
//  GOALSTER
//
//  Created by Daniyar on 8/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController, UIGestureRecognizerDelegate {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        self.isNavigationBarHidden = true
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

