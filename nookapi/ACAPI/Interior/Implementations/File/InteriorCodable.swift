//
//  InteriorCodable.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/13/22.
//

import Foundation

struct InteriorCodable: InteriorProtocol, Codable {
    typealias ItemAvailabilityType = ItemAvailabilityCodable
    typealias ItemBuyType = ItemBuyCodable
    
    let id = UUID()
    //let wikiURL: URL
    let name: String
    let imageURL: URL
    let category: String
    let itemSeries: String
    let itemSet: String
    let hhaCategory: String
    let tag: String
    let hhaBase: Int
    let sell: Int
    let versionAdded: GameVersion
    let unlocked: Bool
    let notes: String
    let gridWidth: Float
    let gridLength: Float
    let itemThemes: [String]
    let colors: [ItemColor]
    let availability: [ItemAvailabilityType]
    let buy: [ItemBuyType]
    
    enum CodingKeys: String, CodingKey {
        //case wikiURL = "url"
        case name
        case imageURL = "image_url"
        case category
        case itemSeries = "item_series"
        case itemSet = "item_set"
        case hhaCategory = "hha_category"
        case tag
        case hhaBase = "hha_base"
        case sell
        case versionAdded = "version_added"
        case unlocked
        case notes
        case gridWidth = "grid_width"
        case gridLength = "grid_length"
        case itemThemes = "themes"
        case colors = "colors"
        case availability
        case buy
    }
}
