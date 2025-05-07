//
//  TrackDetailView.swift
//  ScotPowTechTest
//
//  Created by Calum Maclellan on 07/05/2025.
//

import SwiftUI

struct TrackDetailView: View {
    
    var viewModel: TrackDetailViewModel
    
    var body: some View {
        VStack {
            AsyncImage(url: viewModel.imageURL)
                .frame(maxHeight: .infinity)
          
            HStack{
                    VStack(alignment: .leading) {
                        Text(viewModel.trackName)
                        Text(viewModel.artistName).bold()
                        Text(viewModel.price)
                        Text("")
                        Text(viewModel.duration)
                        Text(viewModel.releaseDate)
                        Spacer()
                    }
                    .padding()
                Spacer()
            }
            
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                Button {
                   //will launch a webview with the trackview url
                }
                label: {
                    Text("More Details")
                }
                Spacer()
            }
            .frame(maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    TrackDetailView(viewModel: TrackDetailViewModel(track: TrackBuilder().build()))
}
