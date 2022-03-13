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
    //var url: URL { get }
    var category: String { get } // Enum?
    var itemSeries: String { get } // Enum?
    var itemSet: String { get } // Enum?
    var hhaCategory: String { get } // Enum?
    var tag: String { get } // Enum?
    var hhaBase: Int { get }
    var lucky: Bool { get }
    var luckySeason: String { get } // Enum?
    var sell: String { get }
    var totalVariations: Int { get }
    var totalPatterns: Int { get }
    var customizable: Bool { get }
    var customKits: Int { get }
    var customKitType: String { get } // Enum?
    var customBodyPart: String { get } // Enum?
    var customPatternPart: String { get } // Enum?
    var height: String { get }
    var doorDecoration: Bool { get }
    var versionAdded: GameVersion { get }
    var unlocked: Bool { get }
    var notes: String { get }
    var gridWidth: Float { get }
    var gridLength: Float { get }
    var furnitureThemes: [String] { get } // Array Enum?
    var functions: String { get } // Enum?
    var availability: [ItemAvailabilityType] { get }
    var buy: [ItemBuyType] { get }
    var variations: [ItemVariationType] { get }
}

/*[{
 "url": "https://nookipedia.com/wiki/Item:1-Up_Mushroom_(New_Horizons)",
 "name": "1-Up Mushroom",
 "category": "Miscellaneous",
 "item_series": "Mario",
 "item_set": "",
 "hha_category": "",
 "tag": "Mario",
 "hha_base": 201,
 "lucky": false,
 "lucky_season": "",
 "sell": 500,
 "variation_total": 0,
 "pattern_total": 0,
 "customizable": false,
 "custom_kits": 0,
 "custom_kit_type": "",
 "custom_body_part": "",
 "custom_pattern_part": "",
 "height": "7.390978",
 "door_decor": false,
 "version_added": "1.8.0",
 "unlocked": true,
 "notes": "",
 "grid_width": 1.0,
 "grid_length": 1.0,
 "themes": ["Fancy", "Child's Room"],
 "functions": [],
 "availability": [{
     "from": "Nook Shopping",
     "note": "''Super Mario Bros.'' 35th anniversary"
 }],
 "buy": [{
     "price": 2000,
     "currency": "Bells"
 }],
 "variations": [{
     "variation": "",
     "pattern": "",
     "image_url": "https://dodo.ac/np/images/7/77/1-Up_Mushroom_NH_Icon.png",
     "colors": ["White", "Green"]
 }]*/
