//
//  ClothesCodable.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/10/22.
//

import Foundation
import SwiftUI

struct ClothesCodable: ClothesProtocol, Codable {
    typealias ItemAvailabilityType = ItemAvailabilityCodable
    typealias ItemBuyType = ItemBuyCodable
    typealias ItemVariationType = ItemVariationCodable
    
    let id = UUID()
    let name: String
    //let wikiURL: URL
    let category: ClothesCategory
    let sell: Int
    let totalVariations: Int
    let villagerEquipable: Bool
    let seasonality: Seasonality
    let versionAdded: GameVersion
    let unlocked: Bool
    let notes: String
    let labelThemes: [ClothesTheme]
    let styles: [ItemStyle]
    let availability: [ItemAvailabilityCodable]
    let buy: [ItemBuyCodable]
    let variations: [ItemVariationCodable]
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        //case wikiURL = "url"
        case category = "category"
        case sell = "sell"
        case totalVariations = "variation_total"
        case villagerEquipable = "vill_equip"
        case seasonality = "seasonality"
        case versionAdded = "version_added"
        case unlocked = "unlocked"
        case notes = "notes"
        case labelThemes = "label_themes"
        case styles = "styles"
        case availability = "availability"
        case buy = "buy"
        case variations = "variations"
    }
}
