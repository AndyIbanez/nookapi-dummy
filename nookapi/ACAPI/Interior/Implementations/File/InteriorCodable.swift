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
    let category: InteriorCategory
    let itemSeries: String
    let itemSet: String
    let hhaCategory: String
    let tag: String
    let hhaBase: Int
    let sell: Int
    let versionAdded: GameVersion
    let unlocked: Bool
    let notes: String
    let gridWidth: Float?
    let gridLength: Float?
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
    
    init(from decoder: Decoder) throws {
        // This entire drama because gridWidth and gridLength are sometimes string, and sometimes float.
        // I hate inconsistent APIs.
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageURL = try container.decode(URL.self, forKey: .imageURL)
        self.category = try container.decode(InteriorCategory.self, forKey: .category)
        self.itemSeries = try container.decode(String.self, forKey: .itemSeries)
        self.itemSet = try container.decode(String.self, forKey: .itemSet)
        self.hhaCategory = try container.decode(String.self, forKey: .hhaCategory)
        self.tag = try container.decode(String.self, forKey: .tag)
        self.hhaBase = try container.decode(Int.self, forKey: .hhaBase)
        self.sell = try container.decode(Int.self, forKey: .sell)
        self.versionAdded = try container.decode(GameVersion.self, forKey: .versionAdded)
        self.unlocked = try container.decode(Bool.self, forKey: .unlocked)
        self.notes = try container.decode(String.self, forKey: .notes)
        self.itemThemes = try container.decode([String].self, forKey: .itemThemes)
        self.colors = try container.decode([ItemColor].self, forKey: .colors)
        self.availability = try container.decode([ItemAvailabilityCodable].self, forKey: .availability)
        self.buy = try container.decode([ItemBuyCodable].self, forKey: .buy)
        
        do {
            let _ = try container.decode(String.self, forKey: .gridWidth)
            self.gridWidth = nil
        } catch {
            self.gridWidth = try container.decode(Float.self, forKey: .gridWidth)
        }
        
        do {
            let _ = try container.decode(String.self, forKey: .gridLength)
            self.gridLength = nil
        } catch {
            self.gridLength = try container.decode(Float.self, forKey: .gridLength)
        }
    }
}
