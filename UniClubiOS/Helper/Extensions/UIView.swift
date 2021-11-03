//
//  UIView.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UIView {
    func showSpinnerViewFull(){
        addSubview(SpinnerView.view)
        SpinnerView.view.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    func showSpinnerViewCenter(){
        addSubview(SpinnerView.circleView)
        SpinnerView.circleView.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
        
        UIView.animate(withDuration: 0.1, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func showSpinnerViewTableView() {
        addSubview(SpinnerView.circleView)
        
        SpinnerView.circleView.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(StaticSize.size(60))
            $0.size.equalTo(StaticSize.size(60))
        })
        
        self.layoutIfNeeded()
        
        SpinnerView.circleView.snp.updateConstraints({
            $0.bottom.equalToSuperview().offset(-(StaticSize.size(100) - SpinnerView.circleView.frame.height) / 2)
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func findConstraint(layoutAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: layoutAttribute) {
            return constraint
        }
        return nil
    }

    func itemMatch(constraint: NSLayoutConstraint, layoutAttribute: NSLayoutConstraint.Attribute) -> Bool {
        let firstItemMatch = constraint.firstItem as? UIView == self && constraint.firstAttribute == layoutAttribute
        let secondItemMatch = constraint.secondItem as? UIView == self && constraint.secondAttribute == layoutAttribute
        return firstItemMatch || secondItemMatch
    }
    
    func addSubViews(_ views: [UIView]){
        for view in views{
            addSubview(view)
        }
    }
    
    func mask(path: UIBezierPath){
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        let scale = self.layer.bounds.width / path.bounds.width
        mask.transform = CATransform3DMakeScale(scale, scale, 1)
        layer.mask = mask
    }
    
    func viewContainingController() -> UIViewController? {
        
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
    
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
    
    enum Direction: Int {
        case topToBottom = 0
        case bottomToTop
        case leftToRight
        case rightToLeft
    }
    
    func addBackground() {
        let background: UIImageView = {
            let view = UIImageView()
            view.image = UIImage(named: "background")
            return view
        }()
        
        addSubview(background)
        
        background.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        sendSubviewToBack(background)
    }
    
    func addBackgroundCenter() {
        let background: UIImageView = {
            let view = UIImageView()
            view.image = UIImage(named: "background")
            return view
        }()
        
        addSubview(background)
        
        background.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
        
        sendSubviewToBack(background)
    }
    
    var globalPoint: CGPoint? {
        guard let superView = viewContainingController()?.view else { return nil }
        return self.convert(self.frame.origin, to: superView)
    }

    var globalFrame: CGRect? {
        guard let superView = viewContainingController()?.view else { return nil }
        return self.convert(self.frame, to: superView)
    }
    
    func addGradientBackground(colors: [UIColor] = [UIColor(hex: "#98F5FA"), UIColor(hex: "#469FA3")], locations: [NSNumber]? = [0.0, 1.0], direction: Direction = .topToBottom) {
        
        let gradientLayer = CAGradientLayer()
        var cgColors: [CGColor] = []
        for color in colors {
            cgColors.append(color.cgColor)
        }
        gradientLayer.frame = self.bounds
        gradientLayer.colors = cgColors
        gradientLayer.locations = locations
        
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        
        self.layer.addSublayer(gradientLayer)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func disable(color: UIColor) {
        let view: UIView = {
            let view = UIView()
            view.backgroundColor = color.withAlphaComponent(0.5)
            return view
        }()
        self.addSubview(view)
        view.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        self.isUserInteractionEnabled = false
    }
}
