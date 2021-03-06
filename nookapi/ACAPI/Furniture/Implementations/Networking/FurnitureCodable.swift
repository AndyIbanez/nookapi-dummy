//
//  FurnitureCodable.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/13/22.
//

import Foundation

struct FurnitureCodable: FurnitureProtocol, Codable {
    typealias ItemAvailabilityType = ItemAvailabilityCodable
    typealias ItemBuyType = ItemBuyCodable
    typealias ItemVariationType = ItemVariationCodable
    
    let id = UUID()
    let name: String
    //let wikiURL: URL
    let category: FurnitureCategory
    let itemSeries: String
    let itemSet: String
    let hhaCategory: String
    let tag: String
    let hhaBase: Int
    let lucky: Bool
    let luckySeason: Seasonality
    let sell: Int
    let totalVariations: Int
    let totalPatterns: Int
    let customizable: Bool
    let customKits: Int
    let customKitType: CustomKitType
    let customBodyPart: String
    let customPatternPart: String
    let height: String
    let doorDecoration: Bool
    let versionAdded: GameVersion
    let unlocked: Bool
    let notes: String
    let gridWidth: Float
    let gridLength: Float
    let furnitureThemes: [String]
    let functions: [String]
    let availability: [ItemAvailabilityType]
    let buy: [ItemBuyType]
    let variations: [ItemVariationType]
    
    enum CodingKeys: String, CodingKey {
        case name
        //case wikiURL = "url"
        case category
        case itemSeries = "item_series"
        case itemSet = "item_set"
        case hhaCategory = "hha_category"
        case tag = "tag"
        case hhaBase = "hha_base"
        case lucky
        case luckySeason = "lucky_season"
        case sell
        case totalVariations = "variation_total"
        case totalPatterns = "pattern_total"
        case customizable
        case customKits = "custom_kits"
        case customKitType = "custom_kit_type"
        case customBodyPart = "custom_body_part"
        case customPatternPart = "custom_pattern_part"
        case height
        case doorDecoration = "door_decor"
        case versionAdded = "version_added"
        case unlocked
        case notes
        case gridWidth = "grid_width"
        case gridLength = "grid_length"
        case furnitureThemes = "themes"
        case functions
        case availability
        case buy
        case variations
    }
}
