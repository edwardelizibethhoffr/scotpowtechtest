//
//  TrackRowViewModelTests.swift
//  ScotPowTechTestTests
//
//  Created by Calum Maclellan on 07/05/2025.
//
@testable import ScotPowTechTest
import XCTest


final class TrackRowViewModelTests: XCTestCase {

    var viewModel: TrackRowViewModel!
    var track: ItunesTrack!
    
    override func setUpWithError() throws {
        track = TrackBuilder()
            .withTrackId(123)
            .withArtistName("Funkadelic")
            .withTrackName("Super Stupid")
            .withPrice(0.99)
            .withCurrency("GBP")
            .withArtworkURL100("https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/71/2d/61/712d617d-f4a4-5904-1b11-d4b4b45c47c5/828768588925.jpg/100x100bb.jpg")
            .build()
        
        viewModel = TrackRowViewModel(track: track)
    }

    func testViewModelReturnsImageUrl() {
        let url = viewModel.imageURL
        XCTAssertNotNil(url)
        let expectedURL = URL(string: track.artworkUrl100)!
        XCTAssertEqual(expectedURL, url)
    }
  
    func testViewModelReturnsExpectedArtistName() {
        let expectedName = track.artistName
        XCTAssertEqual(expectedName, viewModel.artistName)
    }
    
    func testViewModelReturnsExpectedTrackName() {
        let expectedName = track.trackName
        XCTAssertEqual(expectedName, viewModel.trackName)
    }
    
    func testViewModelReturnsExpectedFormattedPrice() {
        let expectedPrice = "£ 0.99"
        XCTAssertEqual(expectedPrice, viewModel.price)
    }

}
