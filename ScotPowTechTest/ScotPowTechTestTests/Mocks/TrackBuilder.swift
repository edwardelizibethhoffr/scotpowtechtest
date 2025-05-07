//
//  TrackBuilder.swift
//  ScotPowTechTest
//
//  Created by Calum Maclellan on 07/05/2025.
//

import Foundation

class TrackBuilder {
    
    private var track = ItunesTrack(wrapperType: "", kind: "", artistID: 0, collectionID: 0, trackID: 0, artistName: "", collectionName: "", trackName: "", collectionCensoredName: "", trackCensoredName: "", artistViewURL: "", collectionViewURL: "", trackViewURL: "", previewURL: "", artworkUrl30: "", artworkUrl60: "", artworkUrl100: "", collectionPrice: 0.0, trackPrice: 0.0, releaseDate: Date(), collectionExplicitness: "", trackExplicitness: "", discCount: 0, discNumber: 0, trackCount: 0, trackNumber: 0, trackTimeMillis: 0, country: "", currency: "", primaryGenreName: "", isStreamable: false)
    
    func withTrackId(_ id: Int) -> TrackBuilder {
        track.trackID = id
        return self
    }
    
    func build() -> ItunesTrack {
        return track
    }
    
}
