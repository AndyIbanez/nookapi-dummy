//
//  ClothesProviderFile.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/12/22.
//

import Foundation

class ClothesProviderFile: ClothesProvider {
    typealias ClothesType = ClothesCodable
    
    let fileURL: URL
    let jsonDecoder: JSONDecoder
    
    init(fileURL: URL, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.fileURL = fileURL
        self.jsonDecoder = jsonDecoder
    }
    
    func fetchClothes(parameters: ClothesRequestParameters) async throws -> [ClothesType] {
        // TODO: Implement filters
        let data = try Data(contentsOf: fileURL)
        let clothes = try jsonDecoder.decode([ClothesType].self, from: data)
        return clothes
    }
}
