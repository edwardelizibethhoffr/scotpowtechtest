//
//  TrackDetailView.swift
//  ScotPowTechTest
//
//  Created by Calum Maclellan on 07/05/2025.
//

import SwiftUI

struct TrackDetailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var viewModel: TrackDetailViewModel
    
    private let imageWidth: CGFloat = 100
    private let imageHeight: CGFloat = 100
    
    var body: some View {
        VStack {
            HStack(alignment: .center){
                
                AsyncImage(url: viewModel.imageURL)
                    .frame(width: imageWidth, height: imageHeight)
                
            }
            .frame(maxHeight: .infinity)
            
            HStack(alignment: .center) {
                if (horizontalSizeClass != .compact)
                {
                    Spacer()
                }
                VStack(alignment: .leading) {
                    Text(viewModel.trackName)
                    Text(viewModel.artistName).bold()
                    Text(viewModel.price)
                    Text("")
                    Text(viewModel.duration)
                    Text(viewModel.releaseDate)
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
