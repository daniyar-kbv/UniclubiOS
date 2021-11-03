//
//  ImageCell.swift
//  GOALSTER
//
//  Created by Daniyar on 8/20/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class ImageCell: UICollectionViewCell, UIScrollViewDelegate {
    static let reuseIdentifier = "ImageCell"
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.minimumZoomScale = 1
        view.maximumZoomScale = 6
        view.delegate = self
        return view
    }()
    
    lazy var image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubViews([scrollView])
        
        scrollView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        scrollView.addSubViews([image])
        
        image.snp.makeConstraints({
            $0.height.equalTo(self)
            $0.width.equalTo(self)
        })
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image
    }
}
