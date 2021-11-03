//
//  Filters.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/10/20.
//

import Foundation

class AgeGroup: Properties {
    var id: Int?
    var fromAge: Int?
    var toAge: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, fromAge = "from_age", toAge = "to_age"
    }
    
    required init() {
        
    }
    
    static var properties: [String] {
        let mirror = Mirror(reflecting: self.init())
        return mirror.children.compactMap { $0.label }
    }
}

class AttendanceType: Properties {
    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    required init() {
        
    }
    
    static var properties: [String] {
        let mirror = Mirror(reflecting: self.init())
        return mirror.children.compactMap { $0.label }
    }
}

class AdministrativeDivision: Properties {
    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    required init() {
        
    }
    
    static var properties: [String] {
        let mirror = Mirror(reflecting: self.init())
        return mirror.children.compactMap { $0.label }
    }
}

class LessonType: Properties {
    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    required init() {
        
    }
    
    static var properties: [String] {
        let mirror = Mirror(reflecting: self.init())
        return mirror.children.compactMap { $0.label }
    }
}

class LessonGroup: Properties {
    var id: Int?
    var name: String?
    var types: [LessonType]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, types
    }
    
    required init() {
        
    }
    
    static var properties: [String] {
        let mirror = Mirror(reflecting: self.init())
        return mirror.children.compactMap { $0.label }
    }
}

class FilterData: Properties {
    var ageGroups: [AgeGroup]?
    var attendanceTypes: [AttendanceType]?
    var administrativeDivisions: [AdministrativeDivision]?
    var lessonGroups: [LessonGroup]?
    var timeTypes: [TimeTypes.RawValue]?
    
    enum CodingKeys: String, CodingKey {
        case ageGroups = "age_groups"
        case attendanceTypes = "attendance_types"
        case administrativeDivisions = "administrative_divisions"
        case lessonGroups = "grade_groups"
        case timeTypes = "time_types"
    }
    
    required init() {
        
    }
    
    static var properties: [String] {
        let mirror = Mirror(reflecting: self.init())
        return mirror.children.compactMap { $0.label }
    }
}

struct SelectedFilters {
    var ageGroups: [Int] = []
    var attendanceTypes: [Int] = []
    var administrativeDivisions: [Int] = []
    var lessonGroups: [Int] = []
    var lessonTypes: [Int] = []
    var timeType: TimeTypes = .allDay
    
    func copy() -> SelectedFilters {
        return SelectedFilters(ageGroups: ageGroups, attendanceTypes: attendanceTypes, administrativeDivisions: administrativeDivisions, lessonGroups: lessonGroups, lessonTypes: lessonTypes, timeType: timeType)
    }
}
