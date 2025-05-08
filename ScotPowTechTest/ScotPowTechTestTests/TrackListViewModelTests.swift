//
//  TrackListViewModelTests.swift
//  ScotPowTechTestTests
//
//  Created by Calum Maclellan on 07/05/2025.
//
@testable import ScotPowTechTest
import XCTest
import SwiftUI
import Combine

final class TrackListViewModelTests: XCTestCase {
    
    var viewModel: TrackListViewModel!
    var mockService: MockItunesService!
    
    override func setUpWithError() throws {
       mockService = MockItunesService()
        viewModel = TrackListViewModel(service: mockService)
    }

    func testFetchTracksCallService() {
        let emptyTrackArray = [ItunesTrack]()
        mockService.testOutcome = .success(data: emptyTrackArray)
        
        let expectedCallCount = 1
        viewModel.fetchTracks()
        
        XCTAssertEqual(expectedCallCount, mockService.fetchTracksCallCounter)
    }
    
    
    func testFetchTracksUpdatesIsFetchingOnSuccess() {
        var cancellables: [AnyCancellable] = []
        let emptyArray: [ItunesTrack] = []
        mockService.testOutcome = .success(data: emptyArray)
        
        var recievedValues: [Bool] = []
        
        let exp = expectation(description: "fetch call updated tracks array")
        
        viewModel.$isFetching.sink(receiveValue: {
            value in
            recievedValues.append(value)
            if (recievedValues.count > 2) {
                exp.fulfill()
            }
        }).store(in: &cancellables)
        
        viewModel.fetchTracks()
        
        wait(for: [exp], timeout: 1)
        // first value is the initial read, second is fetch is started, third is fetch complete
        let expectedIsFetchingValues = [false, true, false]
        
        XCTAssertEqual(viewModel.tracks.count, 0)
        XCTAssertFalse(viewModel.isFetching)
        XCTAssertEqual(expectedIsFetchingValues, recievedValues)
        XCTAssertFalse(viewModel.errorFetching)
    }
    
    func testFetchTracksUpdatesIsFetchingOnFailure() {
        var cancellables: [AnyCancellable] = []
        mockService.testOutcome = .failure(error: AppError.test(description: "Expected test failure"))
        
        var recievedValues: [Bool] = []
        
        let isFetchingExpectation = expectation(description: "fetch call updated tracks array")
        
        viewModel.$isFetching.sink(receiveValue: {
            value in
            recievedValues.append(value)
            if (recievedValues.count > 2) {
                isFetchingExpectation.fulfill()
            }
        }).store(in: &cancellables)
        
        viewModel.fetchTracks()
        
        wait(for: [isFetchingExpectation], timeout: 1)
        // first value is the initial read, second is fetch is started, third is fetch complete
        let expectedIsFetchingValues = [false, true, false]
        
        XCTAssertEqual(viewModel.tracks.count, 0)
        XCTAssertFalse(viewModel.isFetching)
        XCTAssertEqual(expectedIsFetchingValues, recievedValues)
        XCTAssertTrue(viewModel.errorFetching)
    }
    
    func testFetchTracksUpdatesTracksOnSuccess() {
        let tracks = TrackBuilder().build(thisMany: 5)
        
        var cancellables: [AnyCancellable] = []
        mockService.testOutcome = .success(data: tracks)
        
        let tracksUpdatedExpectation = expectation(description: "tracks updated with expected size")
    
        viewModel.tracks = []
        
        viewModel.$tracks.sink(receiveValue: {
            tracks in
            if (tracks.count == 5) {
                tracksUpdatedExpectation.fulfill()
            }
        }).store(in: &cancellables)
        
        viewModel.fetchTracks()
        
        wait(for: [tracksUpdatedExpectation], timeout: 1)
      
        XCTAssertEqual(viewModel.tracks.count, 5)
        XCTAssertFalse(viewModel.isFetching)
        XCTAssertFalse(viewModel.errorFetching)
    }
    
    func testFetchTracksUpdatesTracksToEmptyArrayOnFailure() {
        var cancellables: [AnyCancellable] = []
        mockService.testOutcome = .failure(error: AppError.test(description: "Expected test failure"))
        
        let tracksUpdatedExpectation = expectation(description: "tracks updated to empty array")
        
        let tracks = TrackBuilder().build(thisMany: 5)
        
        viewModel.tracks = tracks.map({TrackRowViewModel(track: $0)})
        
        viewModel.$tracks.sink(receiveValue: {
            tracks in
            if (tracks.count == 0) {
                tracksUpdatedExpectation.fulfill()
            }
        }).store(in: &cancellables)
        
        viewModel.fetchTracks()
        
        wait(for: [tracksUpdatedExpectation], timeout: 1)
      
        XCTAssertEqual(viewModel.tracks.count, 0)
        XCTAssertFalse(viewModel.isFetching)
        XCTAssertTrue(viewModel.errorFetching)
    }
    
    
    func testViewModelReturnsExpectedTitle() {
        XCTAssertEqual("Rock Tracks", viewModel.title)
    }
    
    
    func testFetchedTracksAreSorted() {
        var tracks = TrackBuilder().build(thisMany: 5)
        
        var expectedNamesOrder: [String] = []
        
        for i in 0...tracks.count - 1 {
            let newDate = Calendar.current.date(byAdding: .year, value: i, to: Date())!
            tracks[i].trackName = "Track \(i+1)"
            tracks[i].releaseDate = DateFormatter().dateToItunesAPIString(newDate)
            expectedNamesOrder.insert(tracks[i].trackName, at: 0)
        }
        
        var cancellables: [AnyCancellable] = []
        mockService.testOutcome = .success(data: tracks)
        
        let tracksUpdatedExpectation = expectation(description: "tracks updated with expected size")
    
        viewModel.tracks = []
        
        viewModel.$tracks.sink(receiveValue: {
            tracks in
            if (tracks.count == 5) {
                tracksUpdatedExpectation.fulfill()
            }
        }).store(in: &cancellables)
        
        viewModel.fetchTracks()
        
        wait(for: [tracksUpdatedExpectation], timeout: 1)
      
        let outputNames = viewModel.tracks.map({$0.trackName})
        
        XCTAssertEqual(expectedNamesOrder, outputNames)
        XCTAssertEqual(viewModel.tracks.count, 5)
        XCTAssertFalse(viewModel.isFetching)
        XCTAssertFalse(viewModel.errorFetching)
        
    }

}
