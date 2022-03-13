//
//  ClothesProviderNetworking.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/7/22.
//

import Foundation

class ClothesProviderNetworking: ClothesProvider {
    typealias ClothesType = ClothesCodable
    
    let networkingExecutor: NetworkExecutor
    
    init(networkingExecutor: NetworkExecutor) {
        self.networkingExecutor = networkingExecutor
    }
    
    func fetchClothes(parameters: ClothesRequestParameters) async throws -> [ClothesType] {
        let task = ClothesHTTPTask(parameters: parameters)
        let results = try await networkingExecutor.execute(task)
        return results
    }
}
