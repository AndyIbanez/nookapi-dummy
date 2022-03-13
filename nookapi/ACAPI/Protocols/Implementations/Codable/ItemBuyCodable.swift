//
//  ItemBuyCodable.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/10/22.
//

import Foundation

struct ItemBuyCodable: ItemBuyProtocol, Codable {
    let price: Int
    let currency: ItemCurrency
}
