//
//  FurnitureProvider.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/13/22.
//

import Foundation

protocol FurnitureProvider {
    associatedtype FurnitureType = FurnitureProtocol
    
    func fetchFurniture(parameters: FurnitureRequestParameters) async throws -> [FurnitureType]
}
