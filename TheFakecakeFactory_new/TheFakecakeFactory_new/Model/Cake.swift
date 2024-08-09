//
//  Cake.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 09/08/24.
//

import Foundation

struct CakesResponse: Codable, Hashable {
    let cakes: [Cake]
    
    enum CodingKeys: String, CodingKey {
        case cakes = "DATA"
    }
}

struct Cake: Codable, Hashable {
    let id: Int
    let name: String
    let image: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case id
        case name = "nombre"
        case image = "imagen"
        case description = "descripcion"
    }
}
