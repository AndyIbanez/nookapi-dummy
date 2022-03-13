//
//  ClothesProtocol.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/9/22.
//

import Foundation
import SwiftUI

protocol ClothesProtocol: Identifiable, Equatable {
    associatedtype ItemAvailabilityType
    associatedtype ItemBuyType
    associatedtype ItemVariationType
    
    var name: String { get }
    //var wikiURL: URL { get }
    var category: ClothesCategory { get }
    var sell: Int { get }
    var totalVariations: Int { get }
    var villagerEquipable: Bool { get }
    var seasonality: Seasonality { get }
    var versionAdded: GameVersion { get }
    var unlocked: Bool { get }
    var notes: String { get }
    var labelThemes: [ClothesTheme] { get }
    var styles: [ItemStyle] { get }
    var availability: [ItemAvailabilityType] { get }
    var buy: [ItemBuyType] { get }
    var variations: [ItemVariationType] { get }
}
