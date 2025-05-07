//
//  TrackDetailViewModel.swift
//  ScotPowTechTest
//
//  Created by Calum Maclellan on 07/05/2025.
//
import Foundation

class TrackDetailViewModel {
    
    private let track: ItunesTrack
    
    var artistName: String {
        track.artistName
    }
    
    var imageURL: URL? {
        URL(string: track.artworkUrl100)
    }
    
    var trackName: String {
        track.trackName
    }
    
    var price: String {
        PriceFormatter.getLocalisedPriceLabel(forCode: track.currency, price: track.trackPrice)
    }
    
    var duration: String {
        guard track.trackTimeMillis > 1000 else {
            return "0:0"
        }
        let totalSeconds = track.trackTimeMillis / 1000
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = (totalSeconds % 3600) % 60
        return hours > 0 ? "\(hours):\(minutes):\(seconds)" : "\(minutes):\(seconds)"
    }
    
    var releaseDate: String {
        return DateFormatter().itunesDateString(track.releaseDate) ?? ""
    }
    
    var trackViewURL: URL? {
        return URL(string: track.trackViewURL)
    }
    
    init(track: ItunesTrack) {
        self.track = track
    }
    
}
