//
//  FiltersMainViewModel.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/10/20.
//

import Foundation
import RxSwift

class FiltersMainViewModel {
    lazy var response = PublishSubject<FilterData>()
    
    func getFilterData() {
        SpinnerView.showSpinnerView()
        APIManager.shared.getFilterData() { error, response in
            SpinnerView.completion = {
                guard let response = response else {
                    ErrorView.addToView(text: error ?? "")
                    return
                }
                self.response.onNext(response)
            }
            SpinnerView.removeSpinnerView()
        }
    }
}
