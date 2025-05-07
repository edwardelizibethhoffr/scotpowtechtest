//
//  ItunesDateFormatter.swift
//  ScotPowTechTest
//
//  Created by Calum Maclellan on 07/05/2025.
//
import Foundation

extension DateFormatter {
    func itunesDateString(_ dateString: String) -> String? {
        self.dateFormat = "yyyy-mm-dd'T'HH:mm:ssZ"
        return date(from: dateString)?.formatted(date: .numeric, time: .omitted)
    }
}
