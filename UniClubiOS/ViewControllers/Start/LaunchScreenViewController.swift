//
//  LaunchScreenViewController.swift
//  GOALSTER
//
//  Created by Daniyar on 8/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class LaunchScreenViewController: UIViewController {
    lazy var launchView = LaunchScreenView()
    var timer: Timer?
    lazy var initialTimerValue: Int = 1
    lazy var timerValue: Int = initialTimerValue
    
    override func loadView() {
        super.loadView()
        
        view = launchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        runTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.timerValue == 0{
                self.toMain()
                return
            }
            self.timerValue -= 1
        }
    }
    
    func toMain() {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = .fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        let vc =
        ModuleUserDefaults.getIsInitial() ?
            OnBoardingViewController()
            :
            FiltersMainViewController()
        self.navigationController?.pushViewController(vc, animated: false)
        AppShared.sharedInstance.appLoaded = true
        ModuleUserDefaults.setIsInitial(false)
    }
}
