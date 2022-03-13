//
//  ItemBuyProtocol.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/9/22.
//

import Foundation

protocol ItemBuyProtocol: Equatable {
    var price: Int { get }
    var currency: ItemCurrency { get }
}
