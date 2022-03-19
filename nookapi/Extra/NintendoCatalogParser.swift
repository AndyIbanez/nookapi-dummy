//
//  NintendoCatalogParser.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/12/22.
//

import Foundation

struct SetWithReferenceItemName: Equatable, Hashable {
    let set: Set<String>
    let referenceItemName: String
    let itemCategory: String
    
    static func ==(_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.set == rhs.set
    }
    
    func hash(into hasher: inout Hasher) {
        set.hash(into: &hasher)
    }
}

struct KeyWithPossibleTypes {
    let key: String
    var possibleTypes: Set<String>
}

struct KeysWithPossibleTypes {
    private(set) var keys: [KeyWithPossibleTypes] = []
    
    mutating func insert(key: String, possibleType: String) {
        if var expectedKey = keys.first (where: {  $0.key.caseInsensitiveCompare(key) == .orderedSame }) {
            expectedKey.possibleTypes.insert(possibleType)
        } else {
            let typeSet = Set([possibleType])
            let newKey = KeyWithPossibleTypes(key: key, possibleTypes: typeSet)
            keys.append(newKey)
        }
    }
}

struct VariationEquatable {
    let itemName: String
    let variationName: String
    
    var fullName: String {
        return "\(itemName) (\(variationName))"
    }
}

func jsonSerializationPrinting(file: URL) {
    let data = try! Data(contentsOf: file)
    let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    let catalog = try! JSONDecoder().decode(NintendoCatalog.self, from: data)
    guard let items = json?["items"] as? [[String: Any]] else { return }
    var keysSets: Set<SetWithReferenceItemName> = []
    for item in items {
        var keySet: Set<String> = []
        for key in item.keys {
            keySet.insert(key)
        }
        guard let itemName = item["label"] as? String, let itemCategory = item["ui_category"] as? String else { return }
        let newSet = SetWithReferenceItemName(set: keySet, referenceItemName: itemName, itemCategory: itemCategory)
        keysSets.insert(newSet)
    }
    print("Printing sets (\(keysSets.count)):")
    for keySet in keysSets {
        print("-------\(keySet.referenceItemName) (\(keySet.itemCategory)) (\(keySet.set.count))---------")
        for key in keySet.set {
            print(key)
        }
        print("-------------------------------------------")
    }
    print("All Keys:")
    var allKeys = Set<String>()
    for keySet in keysSets {
        let set = keySet.set
        for key in set {
            allKeys.insert(key)
        }
    }
    allKeys.forEach { print($0) }
    print("-------------")
    print("Uncommon Keys:")
    var uncommonKeys = Set<String>()
    for keySet in keysSets {
        uncommonKeys = allKeys.subtracting(keySet.set)
        for key in uncommonKeys {
            uncommonKeys.insert(key)
        }
    }
    uncommonKeys.forEach { print($0) }
    print("------------")
    print("Attempting to deduce the type for each key...")
    var keysWithTypes = KeysWithPossibleTypes()
    for item in items {
        for key in allKeys {
            if let keyValue = item[key] {
                let mirror = Mirror(reflecting: keyValue)
                let type = mirror.subjectType
                keysWithTypes.insert(key: key, possibleType: "\(type)")
            }
        }
    }
    for kwt in keysWithTypes.keys {
        print("\(kwt.key) - \(kwt.possibleTypes)")
    }
    print("------------")
    Task {
//        print("Interiors")
//        do {
//            let file = Bundle.main.url(forResource: "PhotosPosters", withExtension: "json")!
//            let provider = PhotoPosterProviderFile(fileURL: file)
//            let items = try await provider.fetchPhotoPosters(parameters: PhotoPostersRequestParameters())
//            var set = Set<String>()
//            //items.forEach { set.insert($0.customBodyPart) }
//            //set.forEach { print($0) }
//        } catch {
//            print(error)
//        }
        
        Task {
            // Lets start with clothes
            var ownItems: [String: [String]] = [:]
            var dontOwnItems: [String: [String]] = [:]
            let clothesProvider = ClothesProviderFile(fileURL: Bundle.main.url(forResource: "Clothes", withExtension: "json")!)
            let clothes = try await clothesProvider.fetchClothes(parameters: ClothesRequestParameters())
            for cloth in clothes {
                //print(cloth)
                let catalogItem = catalog.items!.first { cloth.name.caseInsensitiveCompare($0.label!) == .orderedSame }
                //print(catalogItem)
                if let catalogItem = catalogItem {
                    // The item exists
                    let kind = cloth.category.rawValue
                    var itemList = ownItems[kind, default: [String]()]
                    if cloth.totalVariations > 0 {
                        for clothVariation in cloth.variations {
                            var shouldAddToOwn = false
                            for catalogItemVariation in catalogItem.variations! {
                                if catalogItemVariation.name?.caseInsensitiveCompare(clothVariation.variation) == .orderedSame {
                                    shouldAddToOwn = true
                                    break
                                }
                            }
                            if shouldAddToOwn {
                                itemList.append("\(cloth.name) (\(clothVariation.variation))")
                            } else {
                                var dontOwnItemList = dontOwnItems[kind, default: [String]()]
                                dontOwnItemList.append("\(cloth.name) (\(clothVariation.variation))")
                                dontOwnItems[kind] = dontOwnItemList
                            }
                        }
                    } else {
                        itemList.append("\(cloth.name)")
                    }
                    ownItems[kind] = itemList
                } else {
                    // The item doesn't exist
                    let kind = cloth.category.rawValue
                    var itemList = dontOwnItems[kind, default: [String]()]
                    if cloth.totalVariations > 0 {
                        cloth.variations.forEach {
                            itemList.append("\(cloth.name) (\($0.variation))")
                        }
                    } else {
                        itemList.append("\(cloth.name)")
                    }
                    dontOwnItems[kind] = itemList
                }
            }
            // Furniture
            let furnitureProvider = FurnitureProviderFile(fileURL: Bundle.main.url(forResource: "Furniture", withExtension: "json")!)
            let furniture = try await furnitureProvider.fetchFurniture(parameters: FurnitureRequestParameters())
            for item in furniture {
                //print(cloth)
                let catalogItem = catalog.items!.first { item.name.caseInsensitiveCompare($0.label!) == .orderedSame }
                //print(catalogItem)
                if let catalogItem = catalogItem {
                    // The item exists
                    let kind = item.category.rawValue
                    var itemList = ownItems[kind, default: [String]()]
                    if item.totalVariations > 0 {
                        for itemVariation in item.variations {
                            var shouldAddToOwn = false
                            for catalogItemVariation in catalogItem.rebodyPattern! {
                                if catalogItemVariation.name.caseInsensitiveCompare(itemVariation.variation) == .orderedSame {
                                    shouldAddToOwn = true
                                    break
                                }
                            }
                            let fromCrafting = item.availability.contains { $0.from.caseInsensitiveCompare("Crafting") == .orderedSame }
                            let itemToAdd = "\(item.name) (\(itemVariation.variation))\(fromCrafting ? "(Crafting)" : "")"
                            if shouldAddToOwn {
                                if !itemList.contains(itemToAdd) {
                                    itemList.append(itemToAdd)
                                }
                                ownItems[kind] = itemList
                            } else {
                                var dontOwnItemList = dontOwnItems[kind, default: [String]()]
                                if !dontOwnItemList.contains(itemToAdd) {
                                    dontOwnItemList.append(itemToAdd)
                                }
                                dontOwnItems[kind] = dontOwnItemList
                            }
                        }
                    } else {
                        itemList.append("\(item.name)")
                    }
                    ownItems[kind] = itemList
                } else {
                    // The item doesn't exist
                    let kind = item.category.rawValue
                    var itemList = dontOwnItems[kind, default: [String]()]
                    if item.totalVariations > 0 {
                        item.variations.forEach {
                            let itemToAdd = "\(item.name) (\($0.variation))"
                            if !itemList.contains(itemToAdd) {
                                itemList.append(itemToAdd)
                            }
                        }
                    } else {
                        itemList.append("\(item.name)")
                    }
                    dontOwnItems[kind] = itemList
                }
            }
            
            // Interiors
            let interiorsProvider = InteriorProviderFile(fileURL: Bundle.main.url(forResource: "Interior", withExtension: "json")!)
            let interiors = try await interiorsProvider.fetchInteriors(parameters: InteriorsRequestParameters())
            for item in interiors {
                //print(cloth)
                let catalogItem = catalog.items!.first { item.name.caseInsensitiveCompare($0.label!) == .orderedSame }
                //print(catalogItem)
                if let catalogItem = catalogItem {
                    // The item exists
                    let kind = item.category.rawValue
                    var itemList = ownItems[kind, default: [String]()]
                    itemList.append("\(item.name)")
                    ownItems[kind] = itemList
                } else {
                    // The item doesn't exist
                    let kind = item.category.rawValue
                    var itemList = dontOwnItems[kind, default: [String]()]
                    itemList.append("\(item.name)")
                    dontOwnItems[kind] = itemList
                }
            }
            
            // PhotosPosters
//            let photoPosterProvider = PhotoPosterProviderFile(fileURL: Bundle.main.url(forResource: "PhotosPosters", withExtension: "json")!)
//            let photosPosters = try await photoPosterProvider.fetchPhotoPosters(parameters: PhotoPostersRequestParameters())
//            for item in photosPosters {
//                //print(cloth)
//                let catalogItem = catalog.items!.first { item.name.caseInsensitiveCompare($0.label!) == .orderedSame }
//                //print(catalogItem)
//                if let catalogItem = catalogItem {
//                    // The item exists
//                    let kind = item.category.rawValue
//                    var itemList = ownItems[kind, default: [String]()]
//                    if item.variations.count > 0 {
//                        for itemVariation in item.variations {
//                            var shouldAddToOwn = false
//                            print("catalog item name \(item.name)")
//                            for catalogItemVariation in catalogItem.variations! {
//                                if catalogItemVariation.name!.caseInsensitiveCompare(itemVariation.variation) == .orderedSame {
//                                    shouldAddToOwn = true
//                                    break
//                                }
//                            }
//                            if shouldAddToOwn {
//                                itemList.append("\(item.name) (\(itemVariation.variation))")
//                            } else {
//                                var dontOwnItemList = dontOwnItems[kind, default: [String]()]
//                                dontOwnItemList.append("\(item.name) (\(itemVariation.variation))")
//                                dontOwnItems[kind] = dontOwnItemList
//                            }
//                        }
//                    } else {
//                        itemList.append("\(item.name)")
//                    }
//                    ownItems[kind] = itemList
//                } else {
//                    // The item doesn't exist
//                    let kind = item.category.rawValue
//                    var itemList = dontOwnItems[kind, default: [String]()]
//                    if item.variations.count > 0 {
//                        item.variations.forEach {
//                            itemList.append("\(item.name) (\($0.variation))")
//                        }
//                    } else {
//                        itemList.append("\(item.name)")
//                    }
//                    dontOwnItems[kind] = itemList
//                }
//            }
            
            print("Boom")
            
            // Save them to files
            let destination = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let ownDestination = destination.appendingPathComponent("Own", isDirectory: true)
            let dontOwnDestination = destination.appendingPathComponent("No Own", isDirectory: true)
            try? FileManager.default.createDirectory(at: ownDestination, withIntermediateDirectories: true, attributes: nil)
            try? FileManager.default.createDirectory(at: dontOwnDestination, withIntermediateDirectories: true, attributes: nil)
            
            print("Root path \(destination)")
            
            let ownFiles = ownItems.keys
            for file in ownFiles {
                let completeString = ownItems[file]!.reduce("") { $0.appending("\($1)\n") }
                let destinationFile = ownDestination.appendingPathComponent("\(file).txt", isDirectory: false)
                try completeString.write(to: destinationFile, atomically: true, encoding: .utf8)
            }
            
            let dontOwnFiles = dontOwnItems.keys
            
            for file in dontOwnFiles {
                let completeString = dontOwnItems[file]!.reduce("") { $0.appending("\($1)\n") }
                let destinationFile = dontOwnDestination.appendingPathComponent("\(file).txt", isDirectory: false)
                try completeString.write(to: destinationFile, atomically: true, encoding: .utf8)
            }
            
//            for catalogItem in catalog.items! {
//                if catalogItem.kindId == "Tops" {
//                    let item = clothes.first { $0.name == catalogItem.label! }!
//                    if item.totalVariations == 0 {
//
//                    }
//                }
//            }
        }
//        for catalogItem in catalog.items! {
//            set.insert(catalogItem.kindId ?? "oops")
//        }
//        set.forEach { print($0) }
    }
    
    
//    let commonKeys = keysSets.reduce(Set<String>()) { partialResult, currentSet in
//        var bigSet = partialResult
//        for item in currentSet.set {
//            bigSet.insert(item)
//        }
//        return bigSet
//    }
//    commonKeys.forEach { print($0) }
//    print("------------")
//    print("Optional Keys")
//    var allKeys = Set<String>()
//    for keySet in keysSets {
//        let set = keySet.set
//        for key in set {
//            allKeys.insert(key)
//        }
//    }
//    let uncommonKeys = allKeys.subtracting(commonKeys)
//    print("-----------")
//    uncommonKeys.forEach { print($0) }
//    print("-----------")
}

struct RebodyPattern: Codable {
    let index: Int
    let name: String
    let color0: String
    let color1: String
    let icon: String
}

//"region_event": {
//    "name": "Valentine's Day",
//    "period": [{
//        "begin": "2021-02-01",
//        "end": "2021-02-14"
//    }, {
//        "begin": "2022-02-01",
//        "end": "2022-02-14"
//    }],
//    "countries": [{
//        "country_code": "EachCountry",
//        "country": "Intl."
//    }]
    
struct RegionEvent: Codable {
    struct Period: Codable {
        let begin: String?
        let end: String?
    }
    
    struct Country: Codable {
        let countryCode: String?
        let country: String?
        
        enum CodingKeys: String, CodingKey {
            case countryCode = "country_code"
            case country = "country"
        }
    }
    
    let name: String?
    let period: [Period]?
    let countries: [Country]?
}

struct Variation: Codable {
    let uniqueId: Int?
    let name: String?
    let color1: String?
    let color2: String?
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case uniqueId = "unique_id"
        case name = "name"
        case color1 = "color1"
        case color2 = "color2"
        case icon = "icon"
    }
}

struct NintendoCatalog: Codable {
    let updatedAt: TimeInterval?
    let items: [CatalogItem]?
    
    enum CodingKeys: String, CodingKey {
        case updatedAt = "updated_at"
        case items = "items"
    }
}

struct CatalogItem: Codable {
    let HHATheme: Int?
    let itemFossilSetId: Int?
    let rebodyPattern: [RebodyPattern]?
    let regionEvent: RegionEvent?
    let canSell: Int?
    let catalogType: String?
    let color2: String?
    let remakable: Bool?
    let fashionTheme: [String]?
    let label: String?
    let isToolCategory: Bool?
    let variations: [Variation]?
    let icon: String?
    let uiCategory: String?
    let from: String?
    let singleFlag: Bool?
    let itemSizeId: String?
    let kindId: String?
    let color1: String?
    let price: Int?
    let shopRemakable: Bool?
    let uniqueId: Int?
    let smallGenre: String?
    let refabricPattern0Color0: String?
    let refabricPattern0Color1: String?

    enum CodingKeys: String, CodingKey {
        case HHATheme = "hha_theme"
        case itemFossilSetId = "item_fossil_set_id"
        case rebodyPattern = "rebody_pattern"
        case regionEvent = "region_event"
        case canSell = "can_sell"
        case catalogType = "catalog_type"
        case color2 = "color2"
        case remakable = "remakable"
        case fashionTheme = "fashion_theme"
        case label = "label"
        case isToolCategory = "is_tool_category"
        case variations = "variations"
        case icon = "icon"
        case uiCategory = "ui_category"
        case from = "from"
        case singleFlag = "single_flag"
        case itemSizeId = "item_size_id"
        case kindId = "kind_id"
        case color1 = "color1"
        case price = "price"
        case shopRemakable = "shop_remakable"
        case uniqueId = "unique_id"
        case smallGenre = "small_genre"
        case refabricPattern0Color0 = "refabric_pattern0_color0"
        case refabricPattern0Color1 = "refabric_pattern0_color1"
    }
}
