//
//  Cart.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/16/20.
//

import Foundation

class Cart: NSObject, NSCoding {
    var items: [CartItem]?
    
    var title: String {
        var end = ""
        switch "\(items?.count ?? 0)".last {
        case "0", "5", "6", "7", "8", "9":
            end = "занятий"
        case "1":
            end = "занятие"
        case "2", "3", "4":
            end = "занятия"
        default:
            break
        }
        return "Выбрано: \(items?.count ?? 0) \(end)"
    }
    
    init(items: [CartItem]?) {
        self.items = items
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let items = aDecoder.decodeObject(forKey: "items") as? [CartItem]
        self.init(items: items)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(items, forKey: "items")
    }
    
    func add(cartItem: CartItem) {
        items?.append(cartItem)
        onChange()
    }
    
    func remove(cartItem: CartItem) {
        if let index = items?.firstIndex(of: cartItem) {
            items?.remove(at: index)
            onChange()
        }
    }
    
    func clear(courseId: Int? = nil) {
        if let courseId = courseId {
            items?.removeAll(where: {
                $0.courseId == courseId
            })
        } else {
            items?.removeAll()
        }
        onChange()
    }
    
    func onChange() {
        AppShared.sharedInstance.cart = self
        ModuleUserDefaults.setCart(cart: self)
    }
}

class CartItem: NSObject, NSCoding {
    var time: LessonTime?
    var image: String?
    var name: String?
    var courseId: Int?
    
    init(time: LessonTime?, image: String?, name: String?, courseId: Int?) {
        self.time = time
        self.image = image
        self.name = name
        self.courseId = courseId
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let time = aDecoder.decodeObject(forKey: "time") as? LessonTime
        let image = aDecoder.decodeObject(forKey: "image") as? String
        let name = aDecoder.decodeObject(forKey: "name") as? String
        let courseId = aDecoder.decodeObject(forKey: "courseId") as? Int
        self.init(time: time, image: image, name: name, courseId: courseId)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(time, forKey: "time")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(courseId, forKey: "courseId")
    }
}
