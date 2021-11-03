//
//  UIFont.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    class func ptSans(ofSize: CGFloat, weight: PtSansStyles) -> UIFont {
        return UIFont(name: "PTSans-\(weight)", size: ofSize)!
    }
}
