//
//  FiltersMainCell.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/9/20.
//

import Foundation
import SnapKit

class FiltersMainCell: UITableViewCell {
    static let reuseIdentifier = "FiltersMainCell"
    
    var type: FilterType? {
        didSet {
            leftImage.image = type?.logo
            title.text = type?.title
            if type == .lessonType && AppShared.sharedInstance.selectedFilters.lessonGroups.isEmpty  {
                deactivate()
            }
        }
    }
    
    lazy var inactiveLayer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return view
    }()
    
    lazy var leftImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(16), weight: .bold)
        label.textColor = .customDarkBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var subtitle: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(14), weight: .regular)
        label.textColor = .customGreen
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var titleStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [title, subtitle])
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillProportionally
        return view
    }()
    
    lazy var rightImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrowRight")
        return view
    }()
    
    lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func deactivate() {
        leftImage.alpha = 0.2
        title.alpha = 0.2
        rightImage.alpha = 0.2
    }
    
    func activate() {
        leftImage.alpha = 1
        title.alpha = 1
        rightImage.alpha = 1
    }
    
    func setUp() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubViews([leftImage, rightImage, titleStack, bottomLine])
        
        leftImage.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.size(10))
            $0.size.equalTo(StaticSize.size(40))
            $0.centerY.equalToSuperview()
        })
        
        rightImage.snp.makeConstraints({
            $0.right.equalToSuperview().offset(-StaticSize.size(21))
            $0.size.equalTo(StaticSize.size(20))
            $0.centerY.equalToSuperview()
        })
        
        titleStack.snp.makeConstraints({
            $0.left.equalTo(leftImage.snp.right).offset(StaticSize.size(3))
            $0.right.equalTo(rightImage.snp.left).offset(-StaticSize.size(10))
            $0.centerY.equalToSuperview()
        })
        
        bottomLine.snp.makeConstraints({
            $0.right.left.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.size(1))
            $0.bottom.equalToSuperview()
        })
    }
}
