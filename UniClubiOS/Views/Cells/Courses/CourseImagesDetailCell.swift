//
//  CourseImagesDetailCell.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/25/20.
//

import Foundation
import UIKit
import SnapKit

class CourseImagesDetailCell: UICollectionViewCell {
    static let reuseIdentifier = "CourseImagesDetailCell"
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var button: UIButton = {
        let view = UIButton()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([imageView, button])
        
        imageView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        button.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
}
