//
//  AppShared.swift
//  Samokat
//
//  Created by Daniyar on 7/8/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class AppShared {
    static let sharedInstance = AppShared()
    
    var keyWindow: UIWindow?

    var appLoaded = false
    
    var navigationController: UINavigationController!
    lazy var noInternetViewController = NoInternetViewController()
    
    var editingField: UITextField?
    
    lazy var selectedFiltersSubjects = PublishSubject<SelectedFilters>()
    var selectedFilters: SelectedFilters = SelectedFilters() {
        didSet {
            selectedFiltersSubjects.onNext(selectedFilters)
        }
    }
    
    var cartSubject = PublishSubject<Cart>()
    var cart: Cart! {
        didSet {
            cartSubject.onNext(cart)
        }
    }
}
