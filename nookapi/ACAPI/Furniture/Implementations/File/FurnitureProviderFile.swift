//
//  FurnitureProviderFile.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/13/22.
//

import Foundation

class FurnitureProviderFile: FurnitureProvider {
    typealias FurnitureType = FurnitureCodable
    
    let fileURL: URL
    let decoder: JSONDecoder
    
    init(fileURL: URL, decoder: JSONDecoder = JSONDecoder()) {
        self.fileURL = fileURL
        self.decoder = decoder
    }
    
    func fetchFurniture(parameters: FurnitureRequestParameters) async throws -> [FurnitureType] {
        let data = try Data(contentsOf: fileURL)
        let furniture = try decoder.decode([FurnitureType].self, from: data)
        return furniture
    }
}
