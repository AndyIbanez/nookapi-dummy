//
//  ItemVariationOpenInitializer.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/12/22.
//

import Foundation

struct ItemVariationOpenInitializer: ItemVariationProtocol {
    var variation: String
    var imageURL: URL
    var colors: [ItemColor]
}
