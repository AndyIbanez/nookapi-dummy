//
//  ClothesOpenInitializer.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/12/22.
//

import Foundation

struct ClothesOpenInitializer: ClothesProtocol {
    typealias ItemAvailabilityType = ItemAvailabilityOpenInitializer
    typealias ItemBuyType = ItemBuyOpenInitializer
    typealias ItemVariationType = ItemVariationOpenInitializer
    
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
    let availability: [ItemAvailabilityOpenInitializer]
    let buy: [ItemBuyOpenInitializer]
    let variations: [ItemVariationOpenInitializer]
}
