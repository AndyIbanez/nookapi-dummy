//
//  ItemVariationProtocol.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/9/22.
//

import Foundation

protocol ItemVariationProtocol: Equatable {
    var variation: String { get }
    var imageURL: URL { get }
    var colors: [ItemColor] { get }
}
