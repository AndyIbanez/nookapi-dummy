//
//  ItemAvailabilityCodable.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/10/22.
//

import Foundation

struct ItemAvailabilityCodable: ItemAvailabilityProtocol, Codable {
    let from: String
    let note: String
}
