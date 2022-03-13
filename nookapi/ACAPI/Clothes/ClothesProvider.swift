//
//  ClothesProvider.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/7/22.
//

import Foundation

protocol ClothesProvider {
    associatedtype ClothesType = ClothesProtocol
    
    func fetchClothes(parameters: ClothesRequestParameters) async throws -> [ClothesType]
}
