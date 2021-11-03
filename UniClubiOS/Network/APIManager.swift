//
//  APIManager.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

struct APIManager {
    static let shared = APIManager()
    let router = MyRouter<APIPoint>()
    
    func getFilterData(completion:@escaping(_ error:String?,_ module: FilterData?)->()) {
        router.request(.getFilterData, returning: FilterData.self) { error, response in
            completion(error, response)
        }
    }
    
    func getCourses(page: Int, ageGroups: [Int]?, attendanceTypes: [Int]?, lessonGroups: [Int]?, lesonTypes: [Int]?, administrativeSivisions: [Int]?, time: String?, completion:@escaping(_ error:String?,_ module: CoursesResponse?)->()) {
        router.request(.getCourses(page: page, ageGroups: ageGroups, attendanceTypes: attendanceTypes, lessonGroups: lessonGroups, lesonTypes: lesonTypes, administrativeSivisions: administrativeSivisions, time: time), returning: CoursesResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func courseDetail(id: Int, completion:@escaping(_ error:String?,_ module: CourseFull?)->()) {
        router.request(.courseDetail(id: id), returning: CourseFull.self) { error, response in
            completion(error, response)
        }
    }
    
    func partnerApplication(name: String, company_name: String, email: String, mobile_phone: String, completion:@escaping(_ error:String?,_ module: PartnerApplicationResponse?)->()) {
        router.request(.partnerApplication(name: name, company_name: company_name, email: email, mobile_phone: mobile_phone), returning: PartnerApplicationResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func bookingApplication(lessonTimes: [Int], first_name: String, last_name: String, email: String, mobile_phone: String, completion:@escaping(_ error:String?,_ module: BookingApplicationResponse?)->()) {
        router.request(.bookingApplication(lessonTimes: lessonTimes, first_name: first_name, last_name: last_name, email: email, mobile_phone: mobile_phone), returning: BookingApplicationResponse.self) { error, response in
            completion(error, response)
        }
    }
}
