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
        NavigationView {
            ZStack {
                VStack {
                    List($viewModel.tracks, id: \.id) {
                        $track in
                        NavigationLink(destination:
                                       TrackDetailView(viewModel: track.getDetailViewModel() )) {
                            TrackRowView(viewModel: track)
                        }
                    }
                    .refreshable {
                        viewModel.fetchTracks()
                    }
                   
                }
                if (viewModel.isFetching)
                {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(2.0, anchor: .center)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(viewModel.title).font(.title)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert("Error fetching tracks!", isPresented: $viewModel.errorFetching) {
                Button("OK") {}
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
