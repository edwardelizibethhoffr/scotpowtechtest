//
//  ItunesResult.swift
//  ScotPowTechTest
//
//  Created by Calum Maclellan on 07/05/2025.
//

import Foundation


public struct ItunesTrack: Codable {
    var wrapperType, kind: String
    var artistID, collectionID, trackID: Int
    var artistName: String
    var collectionName: String
    var trackName: String
    var collectionCensoredName: String
    var trackCensoredName: String
    var artistViewURL: String
    var collectionViewURL: String
    var trackViewURL: String
    var previewURL: String
    var artworkUrl30, artworkUrl60, artworkUrl100: String
    var collectionPrice, trackPrice: Double
    var releaseDate: Date
    var collectionExplicitness, trackExplicitness: String
    var discCount, discNumber, trackCount, trackNumber: Int
    var trackTimeMillis: Int
    var country: String
    var currency: String
    var primaryGenreName: String
    var isStreamable: Bool
    
    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable
    }
}
