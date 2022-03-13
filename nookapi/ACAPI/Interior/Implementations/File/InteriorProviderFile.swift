//
//  InteriorProviderFile.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/13/22.
//

import Foundation

class InteriorProviderFile: InteriorProvider {
    typealias InteriorType = InteriorCodable
    
    let fileURL: URL
    let decoder: JSONDecoder
    
    init(fileURL: URL, decoder: JSONDecoder = JSONDecoder()) {
        self.fileURL = fileURL
        self.decoder = decoder
    }
    
    func fetchInteriors(parameters: InteriorsRequestParameters) async throws -> [InteriorType] {
        let data = try Data(contentsOf: fileURL)
        let interiors = try decoder.decode([InteriorType].self, from: data)
        return interiors
    }
}
