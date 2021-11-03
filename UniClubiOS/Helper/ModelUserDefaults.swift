//
//  ModelUserDefaults.swift
//  Samokat
//
//  Created by Daniyar on 7/16/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

struct ModuleUserDefaults {
    private static let defaults = UserDefaults.standard
    
    static func setIsInitial(_ value: Bool){
        defaults.setValue(value, forKey: "isInitial")
    }
    
    static func getIsInitial() -> Bool{
        if let value = defaults.value(forKey: "isInitial"){
            if value as! Int == 1{
                return true
            } else {
                return false
            }
        }
        return true
    }
    
    static func setCart(cart: Cart) {
        do {
            let encodedData: Data = try NSKeyedArchiver.archivedData(withRootObject: cart, requiringSecureCoding: false)
            defaults.set(encodedData, forKey: "cart")
            defaults.synchronize()
        } catch {
        }
    }
    
    static func getCart() -> Cart? {
        guard let decoded = defaults.data(forKey: "cart") else {
            return nil
        }
        do {
            let decodedCount = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? Cart
            return decodedCount
        } catch {
            print(error)
            return nil
        }
    }
    
    static func clear(){
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
    }
}
