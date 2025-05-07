//
//  TrackListView.swift
//  ScotPowTechTest
//
//  Created by Calum Maclellan on 07/05/2025.
//

import SwiftUI

struct TrackListView: View {
    
    @StateObject var viewModel = TrackListViewModel(service: ItunesService(networkService: NetworkService()))
    
    var body: some View {
        List($viewModel.tracks, id: \.id) {
            $track in
            NavigationLink(destination: TrackDetailView()) {
                TrackRowView(viewModel: track)
            }
        }
        .onAppear {
            viewModel.fetchTracks()
        }
    }
}

#Preview {
    var vm = TrackListViewModel()
    vm.tracks = [TrackRowViewModel(track: TrackBuilder().build())]
    return TrackListView(viewModel: vm)
}
