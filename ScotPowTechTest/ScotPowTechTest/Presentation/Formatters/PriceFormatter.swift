//
//  PriceFormatter.swift
//  ScotPowTechTest
//
//  Created by Calum Maclellan on 07/05/2025.
//

import Foundation

struct PriceFormatter {
    
    static func getLocalisedPriceLabel(forCode currencyCode: String, price: Double) -> String {
        let currency = getCurrencySymbol(forCode: currencyCode)
        return "\(currency) \(price)"
    }
    
    static func getCurrencySymbol(forCode currencyCode: String) -> String {
        let locale = NSLocale(localeIdentifier: currencyCode)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: currencyCode) ?? ""
    }
}
