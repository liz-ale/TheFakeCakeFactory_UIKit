//
//  Network.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 08/08/24.
//

import Foundation

enum NetworkError: Error {
    case BadURL
    case NoData
    case DecodingError
}

class Network {
    func fetchCakes(completion: @escaping(Result<CakesResponse?, NetworkError>) -> Void) {
        let urlString = "https://eniadesign.com.mx/academia/api/"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(NetworkError.NoData))
            }
            print(data)
            let cakesResponse = try? JSONDecoder().decode(CakesResponse.self, from: data)
            print(cakesResponse)
            if let cakesResponse = cakesResponse {
                completion(.success(cakesResponse))
            } else {
                completion(.failure(.DecodingError))
            }
        }.resume()
    }
}
