//
//  FiltersMainViewController.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/9/20.
//

import Foundation
import UIKit
import RxSwift

class FiltersMainViewController: UIViewController {
    lazy var filtersView = FiltersMainView()
    lazy var viewModel = FiltersMainViewModel()
    lazy var disposeBag = DisposeBag()
    lazy var isFirstOpen = true
    var filterData: FilterData?
    
    override func loadView() {
        super.loadView()
        
        view = filtersView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filtersView.tableView.delegate = self
        filtersView.tableView.dataSource = self
        
        filtersView.navigationBar.rightButton.addTarget(self, action: #selector(clearFilters), for: .touchUpInside)
        filtersView.bottomButton.addTarget(self, action: #selector(openPartnerVc), for: .touchUpInside)
        filtersView.showButton.addTarget(self, action: #selector(openCourses), for: .touchUpInside)
            
        bind()
        viewModel.getFilterData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirstOpen {
            AppShared.sharedInstance.navigationController.delegate = self
            isFirstOpen = false
        } else {
            AppShared.sharedInstance.navigationController.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    func bind() {
        viewModel.response.subscribe(onNext: { response in
            DispatchQueue.main.async {
                self.filterData = response
            }
        }).disposed(by: disposeBag)
        AppShared.sharedInstance.selectedFiltersSubjects.subscribe(onNext: { filters in
            var filters = filters
            DispatchQueue.main.async {
                for i in 0..<self.filtersView.tableView.numberOfRows(inSection: 0) {
                    let cell = self.filtersView.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! FiltersMainCell
                    switch cell.type {
                    case .ageGroup:
                        cell.subtitle.text = filters.ageGroups.map({ id -> String in
                            let foundItem = self.filterData?.ageGroups?.first(where: { item in
                                item.id == id
                            })
                            return "\(foundItem?.fromAge ?? 0) - \(foundItem?.toAge ?? 0)"
                        }).joined(separator: ", ")
                    case .attendanceType:
                        cell.subtitle.text = filters.attendanceTypes.map({ id in
                            self.filterData?.attendanceTypes?.first(where: { item in
                                item.id == id
                            })?.name ?? ""
                        }).joined(separator: ", ")
                    case .administrativeDivision:
                        cell.subtitle.text = filters.administrativeDivisions.map({ id in
                            self.filterData?.administrativeDivisions?.first(where: { item in
                                item.id == id
                            })?.name ?? ""
                        }).joined(separator: ", ")
                    case .lessonGroup:
                        cell.subtitle.text = filters.lessonGroups.map({ id in
                            self.filterData?.lessonGroups?.first(where: { item in
                                item.id == id
                            })?.name ?? ""
                        }).joined(separator: ", ")
                        if filters.lessonGroups.isEmpty {
                            filters.lessonTypes = []
                        }
                    case .lessonType:
                        cell.subtitle.text = (!filters.lessonTypes.isEmpty) ?
                            filters.lessonTypes.map({ id in
                                self.filterData?.lessonGroups?.first(where: { group in
                                    group.types?.contains(where: { type in
                                        type.id == id
                                    }) ?? false
                                })?.types?.first(where: { type in
                                    type.id == id
                                })?.name ?? ""
                            }).joined(separator: ", ") :
                        ""
                        filters.lessonGroups.isEmpty ?
                            cell.deactivate() :
                            cell.activate()
                    default:
                        break
                    }
                }
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func clearFilters() {
        AppShared.sharedInstance.selectedFilters = SelectedFilters()
    }
    
    @objc func openPartnerVc() {
        navigationController?.present(FormViewController(type: .partner), animated: true, completion: nil)
    }
    
    @objc func openCourses() {
        navigationController?.pushViewController(CoursesListViewController(), animated: true)
    }
}

extension FiltersMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FiltersMainCell.reuseIdentifier, for: indexPath) as! FiltersMainCell
        switch indexPath.row {
        case 0:
            cell.type = .ageGroup
        case 1:
            cell.type = .attendanceType
        case 2:
            cell.type = .administrativeDivision
        case 3:
            cell.type = .lessonGroup
        case 4:
            cell.type = .lessonType
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FiltersMainCell
        var vc = FiltersInnerViewController()
        vc.type = cell.type
        switch cell.type {
        case .ageGroup:
            vc.items = filterData?.ageGroups
        case .attendanceType:
            vc.items = filterData?.attendanceTypes
        case .administrativeDivision:
            vc.items = filterData?.administrativeDivisions
        case .lessonGroup:
            vc.items = filterData?.lessonGroups
        case .lessonType:
            vc = FiltersInnerViewController(withSearchField: true)
            vc.type = cell.type
            vc.items = filterData?.lessonGroups?.filter({ group in
                AppShared.sharedInstance.selectedFilters.lessonGroups.contains(where: { $0 == group.id })
            }).map({
                $0.types ?? []
            }).flatMap({ types -> [LessonType] in
                types
            })
        default:
            break
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FiltersMainViewController: UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController is FiltersInnerViewController || viewController is CoursesListViewController {
            AppShared.sharedInstance.navigationController.interactivePopGestureRecognizer?.delegate = self
            AppShared.sharedInstance.navigationController.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
}
