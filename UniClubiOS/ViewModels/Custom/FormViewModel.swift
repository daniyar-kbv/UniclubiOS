//
//  FormViewModel.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/10/20.
//

import Foundation
import RxSwift

class FormViewModel {
    lazy var partnershipResponse = PublishSubject<PartnerApplicationResponse>()
    lazy var bookingResponse = PublishSubject<BookingApplicationResponse>()
    
    func partnerApplicarion(name: String, company_name: String, email: String, mobile_phone: String) {
        SpinnerView.showSpinnerView()
        APIManager.shared.partnerApplication(name: name, company_name: company_name, email: email, mobile_phone: mobile_phone) { error, response in
            SpinnerView.completion = {
                guard let response = response else {
                    ErrorView.addToView(text: error ?? "")
                    return
                }
                self.partnershipResponse.onNext(response)
            }
            SpinnerView.removeSpinnerView()
        }
    }
    
    func bookingApplication(first_name: String, last_name: String, email: String, mobile_phone: String) {
        if let lesson_times = AppShared.sharedInstance.cart.items?.map({
            $0.time?.id ?? 0
        }) {
            SpinnerView.showSpinnerView()
            APIManager.shared.bookingApplication(lessonTimes: lesson_times, first_name: first_name, last_name: last_name, email: email, mobile_phone: mobile_phone) { error, response in
                SpinnerView.completion = {
                    guard let response = response else {
                        ErrorView.addToView(text: error ?? "")
                        return
                    }
                    self.bookingResponse.onNext(response)
                }
                SpinnerView.removeSpinnerView()
            }
        }
    }
}
