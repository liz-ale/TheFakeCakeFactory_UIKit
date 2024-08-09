//
//  AppStorage.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 08/08/24.
//
import Foundation

class CakesInteractor {
    var cakes: CakesResponse?
    var network = Network()
    var favoriteCakes: Set<CakesResponse> = []
    
    func fetchData(completion: @escaping (CakesResponse?) -> Void) {
        network.fetchCakes { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cakesResponse):
                    self?.cakes = cakesResponse
                    completion(cakesResponse)
                case .failure(let error):
                    print("Error fetching cakes: \(error)")
                }
                completion(nil)
            }
        }
    }
}
