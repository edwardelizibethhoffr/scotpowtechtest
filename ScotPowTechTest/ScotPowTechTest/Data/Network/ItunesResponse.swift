//
//  ItunesResponse.swift
//  ScotPowTechTest
//
//  Created by Calum Maclellan on 07/05/2025.
//

import Foundation

public struct ItunesResponse: Decodable {
    let resultCount: Int
    let results: [ItunesTrack]
}
