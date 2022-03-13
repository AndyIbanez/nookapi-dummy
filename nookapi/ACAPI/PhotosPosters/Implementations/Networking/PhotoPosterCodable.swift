//
//  PhotoPosterCodable.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/13/22.
//

import Foundation

struct PhotoPosterCodable: PhotoPosterProtocol, Codable {
    typealias ItemAvailabilityType = ItemAvailabilityCodable
    typealias ItemBuyType = ItemBuyCodable
    typealias ItemVariationType = ItemVariationCodable
    
    let id = UUID()
    let name: String
    //let wikiURL: URL
    let category: PhotoPosterCategory
    let hhaBase: Int
    let sell: Int
    let customizable: Bool
    let customKits: Int
    let customBodyPart: PhotoPosterBodyPart
    let interactable: Bool
    let versionAdded: GameVersion
    let unlocked: Bool
    let gridWidth: Float
    let gridLength: Float
    let availability: [ItemAvailabilityType]
    let buy: [ItemBuyType]
    let variations: [ItemVariationType]
    
    enum CodingKeys: String, CodingKey {
        case name
        //case wikiURL = "url"
        case category
        case hhaBase = "hha_base"
        case sell
        case customizable
        case customKits = "custom_kits"
        case customBodyPart = "custom_body_part"
        case interactable
        case versionAdded = "version_added"
        case unlocked
        case gridWidth = "grid_width"
        case gridLength = "grid_length"
        case availability
        case buy
        case variations
    }
}

/**    {
 "url": "https://nookipedia.com/wiki/Item:Ace's_Photo_(New_Horizons)",
 "name": "Ace's Photo",
 "category": "Photos",
 "hha_base": 351,
 "sell": 10,
 "customizable": true,
 "custom_kits": 1,
 "custom_body_part": "Frame",
 "interactable": true,
 "version_added": "2.0.0",
 "unlocked": true,
 "grid_width": 1.0,
 "grid_length": 1.0,
 "availability": [
     {
         "from": "Friendship",
         "note": ""
     }
 ],
 "buy": [],
 "variations": [
     {
         "variation": "Natural Wood",
         "image_url": "https://dodo.ac/np/images/b/b9/Ace%27s_Photo_%28Natural_Wood%29_NH_Icon.png",
         "colors": [
             "Yellow",
             "Blue"
         ]
     },
     {
         "variation": "Dark Wood",
         "image_url": "https://dodo.ac/np/images/d/d7/Ace%27s_Photo_%28Dark_Wood%29_NH_Icon.png",
         "colors": [
             "Yellow",
             "Blue"
         ]
     },
     {
         "variation": "Pastel",
         "image_url": "https://dodo.ac/np/images/5/5a/Ace%27s_Photo_%28Pastel%29_NH_Icon.png",
         "colors": [
             "Yellow",
             "Blue"
         ]
     },
     {
         "variation": "White",
         "image_url": "https://dodo.ac/np/images/2/2b/Ace%27s_Photo_%28White%29_NH_Icon.png",
         "colors": [
             "Yellow",
             "Blue"
         ]
     },
     {
         "variation": "Pop",
         "image_url": "https://dodo.ac/np/images/9/99/Ace%27s_Photo_%28Pop%29_NH_Icon.png",
         "colors": [
             "Yellow",
             "Blue"
         ]
     },
     {
         "variation": "Colorful",
         "image_url": "https://dodo.ac/np/images/3/36/Ace%27s_Photo_%28Colorful%29_NH_Icon.png",
         "colors": [
             "Yellow",
             "Blue"
         ]
     },
     {
         "variation": "Silver",
         "image_url": "https://dodo.ac/np/images/5/57/Ace%27s_Photo_%28Silver%29_NH_Icon.png",
         "colors": [
             "Yellow",
             "Blue"
         ]
     },
     {
         "variation": "Gold",
         "image_url": "https://dodo.ac/np/images/4/49/Ace%27s_Photo_%28Gold%29_NH_Icon.png",
         "colors": [
             "Yellow",
             "Blue"
         ]
     }
 ]
}*/
