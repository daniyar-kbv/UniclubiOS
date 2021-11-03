//
//  CourseListViewModel.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/12/20.
//

import Foundation
import RxSwift

class CoursesListViewModel {
    var response = PublishSubject<CoursesResponse>()
    
    func getCourses(page: Int = 1) {
        page == 1 ? SpinnerView.showSpinnerView() : SpinnerView.showSpinnerViewTableView()
        APIManager.shared.getCourses(
            page: page,
            ageGroups: AppShared.sharedInstance.selectedFilters.ageGroups,
            attendanceTypes: AppShared.sharedInstance.selectedFilters.attendanceTypes,
            lessonGroups: AppShared.sharedInstance.selectedFilters.lessonGroups,
            lesonTypes: AppShared.sharedInstance.selectedFilters.lessonTypes,
            administrativeSivisions: AppShared.sharedInstance.selectedFilters.administrativeDivisions,
            time: AppShared.sharedInstance.selectedFilters.timeType.rawValue
            ) { error, response in
            SpinnerView.completion = {
                guard let response = response else {
                    ErrorView.addToView(text: error ?? "")
                    return
                }
                self.response.onNext(response)
            }
            page == 1 ? SpinnerView.removeSpinnerView() : SpinnerView.removeSpinnerViewTableView()
        }
    }
}
