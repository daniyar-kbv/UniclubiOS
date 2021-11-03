//
//  CoursesListViewController.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/12/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class CoursesListViewController: UIViewController {
    lazy var coursesView = CoursesListView()
    lazy var viewModel = CoursesListViewModel()
    lazy var disposeBag = DisposeBag()
    
    var courses: [CourseShort]? {
        didSet {
            coursesView.tableView.reloadData()
            gotData = true
            coursesView.showNoCourses(courses?.count == 0)
        }
    }
    var page = 1
    var totalPages: Int?
    lazy var gotData = false
    lazy var count = 0
    var disposableFilters: Disposable?
    
    override func loadView() {
        super.loadView()
        
        view = coursesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coursesView.tableView.delegate = self
        coursesView.tableView.dataSource = self
        
        coursesView.noCoursesButton.addTarget(self, action: #selector(noCoursesButtonTapped), for: .touchUpInside)
        
        viewModel.getCourses(page: page)
        
        bind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        disposableFilters?.dispose()
    }
    
    func bind() {
        viewModel.response.subscribe(onNext: { respose in
            DispatchQueue.main.async {
                self.totalPages = respose.total_pages
                
                if self.page == 1 {
                    self.courses = respose.results
                } else {
                    self.courses?.append(contentsOf: respose.results ?? [])
                }
            }
        }).disposed(by: disposeBag)
        disposableFilters = AppShared.sharedInstance.selectedFiltersSubjects.subscribe(onNext: { selected in
            DispatchQueue.main.async {
                self.page = 1
                self.count = 0
                self.viewModel.getCourses(page: self.page)
            }
        })
    }
    
    @objc func noCoursesButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension CoursesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoursesListCell.reuseIdentifier, for: indexPath) as! CoursesListCell
        cell.course = courses?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tableView.numberOfRows(inSection: 0) && gotData {
            if count > 0 && page < totalPages ?? 0{
                page += 1
                viewModel.getCourses(page: page)
            }
            count += 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CoursesListCell
        let vc = СourseDetailViewController()
        vc.courseId = cell.course?.id
        navigationController?.pushViewController(vc, animated: true)
    }
}
