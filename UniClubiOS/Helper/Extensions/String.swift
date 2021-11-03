//
//  String.swift
//  Samokat
//
//  Created by Daniyar on 7/8/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension String {
    internal func format(mask: String = "+X XXX XXX XX XX") -> String {
        let cleanPhoneNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    internal func changeSubstringFont(lastElement: String, font: UIFont) -> NSAttributedString{
        let firstIndex = self.index(self.startIndex, offsetBy: 12)
        let lastIndex = self.range(of: lastElement)
        let substring = self[firstIndex...lastIndex!.lowerBound]
        return self.substringFont(substring: String(substring), changedFont: font)
    }
    
    internal func substringFont(substring: String, changedFont: UIFont) -> NSAttributedString{
        let longestWord = substring
        let longestWordRange = (self as NSString).range(of: longestWord)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.setAttributes([NSAttributedString.Key.font: changedFont], range: longestWordRange)
        return attributedString
    }
    
    internal func formatDateTime(inputFormat: String = "yyyy-MM-dd'T'HH:mm:ss", outputFormat: String) -> String{
        let dateFormatterIn = DateFormatter()
        dateFormatterIn.dateFormat = inputFormat
        let dateFormatterOut = DateFormatter()
        dateFormatterOut.dateFormat = outputFormat
        if let date = dateFormatterIn.date(from: self) {
            return dateFormatterOut.string(from: date)
        } else {
            return ""
        }
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func toDate(format: String = "dd-MM-yyyy") -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func underline(substring: String) -> NSMutableAttributedString {
        let range = (self as NSString).range(of: substring)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSNumber(value: 1), range: range)
        return attributedString
    }
    
    func getRange(start: Int = 0, end: Int) -> String? {
        let startIndex_ = index(startIndex, offsetBy: start)
        let index_ = index(startIndex, offsetBy: end)
        return String(self[startIndex_..<index_])
    }
}
