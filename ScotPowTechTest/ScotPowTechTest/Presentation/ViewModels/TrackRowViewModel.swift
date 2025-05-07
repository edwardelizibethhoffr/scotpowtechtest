//
//  TrackRowViewModel.swift
//  ScotPowTechTest
//
//  Created by Calum Maclellan on 07/05/2025.
//
import Foundation


class TrackRowViewModel: Identifiable {
    
    private let track: ItunesTrack
    
    var imageURL: URL? {
        URL(string: track.artworkUrl100)
    }
    
    var trackName: String {
        track.trackName
    }
    
    var artistName: String {
        track.artistName
    }
    
    var price: String {
        getLocalisedPriceLabel()
    }
    
    init(track: ItunesTrack) {
        self.track = track
    }
    
    private func getLocalisedPriceLabel() -> String {
        let currency = getCurrencySymbol(forCode: track.currency)
        return "\(currency) \(track.trackPrice)"
    }
    
    private func getCurrencySymbol(forCode currencyCode: String) -> String {
        let locale = NSLocale(localeIdentifier: currencyCode)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: currencyCode) ?? ""
    }
}
