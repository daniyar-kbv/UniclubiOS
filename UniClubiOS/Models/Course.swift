//
//  Course.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/12/20.
//

import Foundation

class Profile: Properties {
    var websiteUrl: String?
    var aboutClub: String?
    var clubName: String?
    var contacts: String?
    
    enum CodingKeys: String, CodingKey {
        case contacts
        case aboutClub = "about_club"
        case clubName = "club_name"
        case websiteUrl = "website_url"
    }
    
    required init() {
        
    }
    
    static var properties: [String] {
        let mirror = Mirror(reflecting: self.init())
        return mirror.children.compactMap { $0.label }
    }
}

class User: Properties {
    var profile: Profile?
    
    enum CodingKeys: String, CodingKey {
        case profile
    }
    
    required init() {
        
    }
    
    static var properties: [String] {
        let mirror = Mirror(reflecting: self.init())
        return mirror.children.compactMap { $0.label }
    }
}

class LessonTime: NSObject, NSCoding, Properties {
    var id: Int?
    var fromTime: String?
    var toTime: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fromTime = "from_time"
        case toTime = "to_time"
    }
    
    required override init() {
        
    }
    
    init(id: Int?, fromTime: String?, toTime: String?) {
        self.id = id
        self.fromTime = fromTime
        self.toTime = toTime
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as? Int
        let fromTime = aDecoder.decodeObject(forKey: "fromTime") as? String
        let toTime = aDecoder.decodeObject(forKey: "toTime") as? String
        self.init(id: id, fromTime: fromTime, toTime: toTime)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(fromTime, forKey: "fromTime")
        aCoder.encode(toTime, forKey: "toTime")
    }
    
    static var properties: [String] {
        let mirror = Mirror(reflecting: self.init())
        return mirror.children.compactMap { $0.label }
    }
}

class WeekDay: Properties {
    var id: Int?
    var day: WeekDays.RawValue?
    var lessonTimes: [LessonTime]?
    
    enum CodingKeys: String, CodingKey {
        case id, day
        case lessonTimes = "lesson_times"
    }
    
    required init() {
        
    }
    
    static var properties: [String] {
        let mirror = Mirror(reflecting: self.init())
        return mirror.children.compactMap { $0.label }
    }
}

class CourseShort: Properties {
    var id: Int?
    var name: String?
    var shortDescription: String?
    var image: String?
    var user: User?
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, user
        case shortDescription = "short_description"
    }
    
    required init() {
        
    }
    
    static var properties: [String] {
        let mirror = Mirror(reflecting: self.init())
        return mirror.children.compactMap { $0.label }
    }
}

class CoursesResponse: Properties {
    var page: Int?
    var total_pages: Int?
    var results: [CourseShort]?
    
    enum CodingKeys: String, CodingKey {
        case page, total_pages, results
    }
    
    required init() {
        
    }
    
    static var properties: [String] {
        let mirror = Mirror(reflecting: self.init())
        return mirror.children.compactMap { $0.label }
    }
}

class CourseFull: Properties {
    var id: Int?
    var name: String?
    var description: String?
    var images: [String]?
    var weekdays: [WeekDay]?
    var user: User?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, images, weekdays, user
    }
    
    required init() {
        
    }
    
    static var properties: [String] {
        let mirror = Mirror(reflecting: self.init())
        return mirror.children.compactMap { $0.label }
    }
}
