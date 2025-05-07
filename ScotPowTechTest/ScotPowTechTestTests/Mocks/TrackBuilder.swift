//
//  TrackBuilder.swift
//  ScotPowTechTest
//
//  Created by Calum Maclellan on 07/05/2025.
//

@testable import ScotPowTechTest
import Foundation

//was created to easily build multiple tracks for testing but is also useful for Previews

class TrackBuilder {
    
    private var track = ItunesTrack(trackID: 0,
                                    artistName: "Journey",
                                    trackName: "Don't Stop Believin' (2024 Remaster)",
                                    trackPrice: 0.99,
                                    currency: "USD",
                                    artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/71/2d/61/712d617d-f4a4-5904-1b11-d4b4b45c47c5/828768588925.jpg/100x100bb.jpg",
                                    trackTimeMillis: 0,
                                    releaseDate: "",
                                    trackViewURL: ""
                                   )
    
    func withTrackId(_ id: Int) -> TrackBuilder {
        track.trackID = id
        return self
    }
    
    func withArtistName(_ name: String) -> TrackBuilder {
        track.artistName = name
        return self
    }
    
    func withTrackName(_ name: String) -> TrackBuilder {
        track.trackName = name
        return self
    }
    
    func withPrice(_ price: Double) -> TrackBuilder {
        track.trackPrice = price
        return self
    }
    
    func withCurrency(_ currency: String) -> TrackBuilder {
        track.currency = currency
        return self
    }
    
    func withArtworkURL100(_ urlString: String) -> TrackBuilder {
        track.artworkUrl100 = urlString
        return self
    }
    
    func build() -> ItunesTrack {
        return track
    }
    
}
