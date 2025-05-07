//
//  TrackListViewModel.swift
//  ScotPowTechTest
//
//  Created by Calum Maclellan on 07/05/2025.
//

import Foundation
import SwiftUI
import Combine

class TrackListViewModel: TrackListViewModelProtocol,  ObservableObject {
    
    @Published var tracks: [TrackRowViewModel] = []
    
    private let service: ItunesServiceProtocol
    private let defaultTerm = "rock"
    private var disposables = Set<AnyCancellable>()
    
    init(service: ItunesServiceProtocol = ItunesService()) {
        self.service = service
    }
    
    func fetchTracks() {
        service.fetchTracks(forTerm: defaultTerm)
            .print()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                [weak self] value in
                guard let self = self else {return}
                
                switch value {
                case .failure:
                    self.tracks = []
                    //update the ui that there was an error
                    print("Failed")
                case .finished:
                  break
                }
                
            }, receiveValue: {
                [weak self] trackResult in
                guard let self = self else {return}
                
                self.tracks = trackResult.map {TrackRowViewModel(track: $0)}
            })
            .store(in: &disposables)
    }
    
}


protocol TrackListViewModelProtocol {
    
    func fetchTracks()
    
}
