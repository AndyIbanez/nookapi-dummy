//
//  FurnitureProtocol.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/13/22.
//

import Foundation

protocol FurnitureProtocol: Identifiable {
    associatedtype ItemAvailabilityType = ItemAvailabilityProtocol
    associatedtype ItemBuyType = ItemBuyProtocol
    associatedtype ItemVariationType = ItemVariationProtocol
    
    var id: UUID { get }
    var name: String { get }
    //var wikiURL: URL { get }
    var category: FurnitureCategory { get }
    var itemSeries: String { get }
    var itemSet: String { get }
    var hhaCategory: String { get }
    var tag: String { get }
    var hhaBase: Int { get }
    var lucky: Bool { get }
    var luckySeason: Seasonality { get }
    var sell: Int { get }
    var totalVariations: Int { get }
    var totalPatterns: Int { get }
    var customizable: Bool { get }
    var customKits: Int { get }
    var customKitType: CustomKitType { get }
    var customBodyPart: String { get }
    var customPatternPart: String { get }
    var height: String { get }
    var doorDecoration: Bool { get }
    var versionAdded: GameVersion { get }
    var unlocked: Bool { get }
    var notes: String { get }
    var gridWidth: Float { get }
    var gridLength: Float { get }
    var furnitureThemes: [String] { get }
    var functions: [String] { get }
    var availability: [ItemAvailabilityType] { get }
    var buy: [ItemBuyType] { get }
    var variations: [ItemVariationType] { get }
}

