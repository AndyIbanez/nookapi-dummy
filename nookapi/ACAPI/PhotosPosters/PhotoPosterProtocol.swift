//
//  PhotoPosterProtocol.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/13/22.
//

import Foundation

protocol PhotoPosterProtocol: Identifiable {
    associatedtype ItemAvailabilityType = ItemAvailabilityProtocol
    associatedtype ItemBuyType = ItemBuyProtocol
    associatedtype ItemVariationType = ItemVariationProtocol
    
    var name: String { get }
    // var wikiURL: URL { get }
    var category: PhotoPosterCategory { get }
    var hhaBase: Int { get }
    var sell: Int { get }
    var customizable: Bool { get }
    var customKits: Int { get }
    var customBodyPart: PhotoPosterBodyPart { get }
    var interactable:  Bool { get }
    var versionAdded: GameVersion { get }
    var unlocked: Bool { get }
    var gridWidth: Float { get }
    var gridLength: Float { get }
    var availability: [ItemAvailabilityType] { get }
    var buy: [ItemBuyType] { get }
    var variations: [ItemVariationType] { get }
}
