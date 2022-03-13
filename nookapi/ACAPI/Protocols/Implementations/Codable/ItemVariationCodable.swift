//
//  ItemVariationCodable.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/10/22.
//

import Foundation

struct ItemVariationCodable: ItemVariationProtocol, Codable {
    let variation: String
    let imageURL: URL
    let colors: [ItemColor]
    
    enum CodingKeys: String, CodingKey {
        case variation = "variation"
        case colors = "colors"
        case imageURL = "image_url"
    }
}
