//
//  InteriorProvider.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/13/22.
//

import Foundation

protocol InteriorProvider {
    associatedtype InteriorType = InteriorProtocol
    
    func fetchInteriors(parameters: InteriorsRequestParameters) async throws -> [InteriorType]
}
