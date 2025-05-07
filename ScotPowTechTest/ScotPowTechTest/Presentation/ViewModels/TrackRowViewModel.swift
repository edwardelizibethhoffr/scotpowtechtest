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
        PriceFormatter.getLocalisedPriceLabel(forCode: track.currency, price: track.trackPrice)
    }
    
    init(track: ItunesTrack) {
        self.track = track
    }
    
    func getDetailViewModel() -> TrackDetailViewModel {
        return TrackDetailViewModel(track: track)
    }
}
