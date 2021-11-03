//
//  PartnerApplication.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/10/20.
//

import Foundation

protocol Properties: Codable {
    static var properties: [String] { get }
}

class PartnerApplicationResponse: Properties {
    var id: Int?
    var name: String?
    var company_name: String?
    var email: String?
    var mobile_phone: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, company_name, email, mobile_phone
    }
    
    required init() {
        
    }
    
    static var properties: [String] {
        let mirror = Mirror(reflecting: self.init())
        return mirror.children.compactMap { $0.label }
    }
}

class BookingApplicationResponse: Properties {
    var id: Int?
    var first_name: String?
    var last_name: String?
    var email: String?
    var phone_number: String?
    
    enum CodingKeys: String, CodingKey {
        case id, first_name, last_name, email, phone_number
    }
    
    required init() {
        
    }
    
    static var properties: [String] {
        let mirror = Mirror(reflecting: self.init())
        return mirror.children.compactMap { $0.label }
    }
}
