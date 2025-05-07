//
//  NetworkService.swift
//  ScotPowTechTest
//
//  Created by Calum Maclellan on 07/05/2025.
//

import Foundation
import Combine

public class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
      self.session = session
    }
    
    func fetch<T: Decodable>(_ t: T.Type, url: URL) -> AnyPublisher<T, Error> {
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .subscribe(on: DispatchQueue.global(qos: .default))
            .mapError {
                error in
                return AppError.network(description: error.localizedDescription)
            }
            .tryMap() { output -> Data in
                //catch any responses that are not 200
                guard let httpResponse = output.response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                    throw AppError.network(description: "Request failed. Response was not 200")
                  }
                return output.data
              }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(_ t: T.Type, url: URL) -> AnyPublisher<T, Error>
}
