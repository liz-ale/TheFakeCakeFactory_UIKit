//
//  HomeViewModel.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 09/08/24.
//
import Foundation

class HomeViewModel {
    let interactor: CakesInteractor
    var cakes: [Cake] = []
    var updateUI: (() -> Void)?
    
    init(interactor: CakesInteractor = CakesInteractor()) {
        self.interactor = interactor
    }
    
    func fetchCakes() {
        //nuevos datos 
        interactor.fetchData { [weak self] response in
            guard let self = self else { return }
            guard let response else { return }
            self.cakes = response.cakes
            self.updateUI?()
            print(self.cakes)
        }
    }
    
    func cake(at index: Int) -> Cake? {
        guard index >= 0 && index < cakes.count else { return nil }
        return cakes[index]
    }
    
    func numberOfCakes() -> Int {
        return cakes.count
    }
    
    func loadMoreCakes(completion: @escaping (Bool) -> Void) {
        // Implementar la lógica de paginación aquí
        // Simulación de carga adicional
        self.fetchCakes()
        completion(true)
    }
}

