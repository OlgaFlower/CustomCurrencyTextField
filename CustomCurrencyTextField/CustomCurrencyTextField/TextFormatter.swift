//
//  TextFormatter.swift
//  CustomCurrencyTextField
//
//  Created by Olha Bereziuk on 07.05.24.
//

import Foundation

final class TextFormatter {
    
    private init() {}
    
    // MARK: - Text to Currency format -
    
    static func textToCurrency(_ inputString: String) -> String {
        
        var formattedAmount = ""
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        let groupingSeparator = Locale.current.groupingSeparator ?? ","
        
        // Remove non-numeric characters
        let cleanAmount = inputString.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        // Add thousands separator
        let length = cleanAmount.count
        for i in 0..<length {
            /// "-2" means last 2 digits (after comma; cents)
            if i > 0 && ((length - 2) - i) % 3 == 0 {
                formattedAmount += groupingSeparator
            }
            let index = cleanAmount.index(cleanAmount.startIndex, offsetBy: i)
            formattedAmount += String(cleanAmount[index]).reversed()
        }
        
        // Add decimal separator
        if length >= 3 {
            let index = formattedAmount.index(formattedAmount.endIndex, offsetBy: -2)
            formattedAmount.insert(contentsOf: decimalSeparator, at: index)
        }
        return formattedAmount
    }
}
