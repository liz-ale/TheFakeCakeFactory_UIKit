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
    var favoriteCakes: Set<Cake> = []
    
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
    
    func addFavorite(cake: Cake) {
        favoriteCakes.insert(cake)
    }
    
    func removeFavorite(cake: Cake) {
        favoriteCakes.remove(cake)
    }
    
    func isFavorite(cake: Cake) -> Bool {
        return favoriteCakes.contains(cake)
    }
}
