//
//  InteriorProtocol.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/13/22.
//

import Foundation

protocol InteriorProtocol: Identifiable {
    associatedtype ItemAvailabilityType = ItemAvailabilityProtocol
    associatedtype ItemBuyType = ItemBuyProtocol
    
    var id: UUID { get }
    var name: String { get }
    //var wikiURL: URL { get }
    var imageURL: URL { get }
    var category: String { get } // Enum?
    var itemSeries: String { get }
    var itemSet: String { get }
    var hhaCategory: String { get }
    var tag: String { get }
    var hhaBase: Int { get }
    var sell: Int { get }
    var versionAdded: GameVersion { get }
    var unlocked: Bool { get }
    var notes: String { get }
    var gridWidth: Float { get }
    var gridLength: Float { get }
    var itemThemes: [String] { get }
    var colors: [ItemColor] { get }
    var availability: [ItemAvailabilityType] { get }
    var buy: [ItemBuyType] { get }
}
