//
//  EndPoint.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import Alamofire

enum APIPoint {
    case getFilterData
    case getCourses(page: Int, ageGroups: [Int]?, attendanceTypes: [Int]?, lessonGroups: [Int]?, lesonTypes: [Int]?, administrativeSivisions: [Int]?, time: String?)
    case courseDetail(id: Int)
    case partnerApplication(name: String, company_name: String, email: String, mobile_phone: String)
    case bookingApplication(lessonTimes: [Int], first_name: String, last_name: String, email: String, mobile_phone: String)
    case test(ids: [Int])
}

extension APIPoint: EndPointType {
    var path: String {
        switch self {
        case .getFilterData:
            return "/other/filters/"
        case .getCourses:
            return "/main/courses/"
        case .courseDetail(let id):
            return "/main/courses/\(id)/"
        case .partnerApplication:
            return "/applications/partnership/"
        case .bookingApplication:
            return "/applications/booking/"
        case .test:
            return "/main/courses/"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .partnerApplication, .bookingApplication:
            return .post
        default:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getCourses(let page, let ageGroups, let attendanceTypes, let lessonGroups, let lessonTypes, let administrativeDivisions, let time):
            var parameters: Parameters = [
                "page": page
            ]
            if let val = ageGroups {
                parameters["age_groups"] = val
            }
            if let val = attendanceTypes {
                parameters["attendance_types"] = val
            }
            if let val = lessonGroups {
                parameters["grade_groups"] = val
            }
            if let val = lessonTypes {
                parameters["grade_types"] = val
            }
            if let val = administrativeDivisions {
                parameters["administrative_divisions"] = val
            }
            if let val = time {
                parameters["time"] = val
            }
            return parameters
        case .partnerApplication(let name, let company_name, let email, let mobile_phone):
            return [
                "name": name,
                "company_name": company_name,
                "email": email,
                "mobile_phone": mobile_phone
            ]
        case .bookingApplication(let lessonTimes, let first_name, let last_name, let email, let mobile_phone):
            return [
                "lesson_times": lessonTimes,
                "first_name": first_name,
                "last_name": last_name,
                "email": email,
                "phone_number": mobile_phone
            ]
        default:
            return nil
        }
    }
    
    var encoding: Encoder.Encoding {
        switch self {
        case .getCourses, .test:
            return .urlEncoding
        default:
            return .jsonEncoding
        }
    }
    
    var additionalHeaders: HTTPHeaders? {
        switch self {
        default:
            return nil
        }
    }
    
    var baseURL: URL {
        return URL(string: "http://185.146.1.36:8990")!
//        return URL(string: "http://192.168.1.19:8990")!
    }
    
    var header: HTTPHeaders? {
        switch self {
        default:
            return [:]
        }
    }
}
