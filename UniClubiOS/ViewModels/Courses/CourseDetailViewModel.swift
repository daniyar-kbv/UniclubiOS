//
//  CourseDetailViewModel.swift
//  UniClubiOS
//
//  Created by Daniyar on 13.12.2020.
//

import Foundation
import RxSwift

class CourseDetailViewModel {
    lazy var course = PublishSubject<CourseFull>()
    
    func getCourse(id: Int) {
        SpinnerView.showSpinnerView()
        APIManager.shared.courseDetail(id: id) { error, response in
            SpinnerView.completion = {
                guard let response = response else {
                    ErrorView.addToView(text: error ?? "")
                    return
                }
                self.course.onNext(response)
            }
            SpinnerView.removeSpinnerView()
        }
    }
}
