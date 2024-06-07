//
//  UIString+Extensions.swift
//  EasyRide-IOS
//
//  Created by Madan Mohan Avulagadda on 21/05/24.
//

import Foundation

let basicPhoneFormat = "(XXX) XXX-XXXX"
let indiaPhoneFormat = "XXXXXXXXXX"


extension String {
    
    func isValidPhoneNumber(formatLength: Int = basicPhoneFormat.count) -> Bool {
        // FIXME: Update once confirmed
        if self.count != formatLength {
            return false
        }
        return true
    }
    
    func isValidIndiaPhoneNumber(formatLength: Int = indiaPhoneFormat.count) -> Bool {
        // FIXME: Update once confirmed
        if self.count != formatLength {
            return false
        }
        return true
    }
    
    // With country code
    /// mask example: `(XXX) XXX-XXXX`
    func formatPhoneNumber(with mask: String = basicPhoneFormat) -> String {
        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}

extension String {
    var decodedUnicode: String {
        let temp = self.replacingOccurrences(of: "\\u", with: "\\U")
                            .replacingOccurrences(of: "\"", with: "\\\"")
        let data = "\"\(temp)\"".data(using: .utf8)!
        return try! PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! String
    }
}
