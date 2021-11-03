//
//  FiltersInnerViewController.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/10/20.
//

import Foundation
import UIKit

class FiltersInnerViewController: UIViewController {
    var filterView: FiltersInnerView
    var type: FilterType? {
        didSet {
            filterView.navigationBar.setTitle(type?.title ?? "")
        }
    }
    var items: [Properties]? {
        didSet {
            filteredItems = items
        }
    }
    var filteredItems: [Properties]? {
        didSet {
            filterView.tableView.reloadData()
        }
    }
    var selectedFilters: SelectedFilters = AppShared.sharedInstance.selectedFilters.copy()
    
    required init(withSearchField: Bool = false) {
        filterView = FiltersInnerView(withSearchField: withSearchField)
        
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = filterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterView.tableView.delegate = self
        filterView.tableView.dataSource = self
        
        filterView.navigationBar.isBottomLineHidden = false
        
        filterView.searchField.onChange = onSearch
        
        filterView.bottomButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        hideKeyboardWhenTappedAround()
    }
    
    func onSearch(_ text: String) {
        if self.type == .lessonType, let items = items as? [LessonType]{
            filteredItems = items.filter({
                return text == "" ?
                    true :
                    $0.name?.lowercased().contains(text.lowercased()) ?? false
            })
        }
    }
    
    @objc func buttonTapped() {
        AppShared.sharedInstance.selectedFilters = selectedFilters
        navigationController?.popViewController(animated: true)
    }
}

extension FiltersInnerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FiltersInnerCell.reuseIdentifier, for: indexPath) as! FiltersInnerCell
        cell.type = type
        cell.item = filteredItems?[indexPath.row]
        cell.superVc = self
        return cell
    }
}
