//
//  ClothesEnums.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/7/22.
//

import Foundation

enum ClothesCategory: String, CaseIterable, Codable, URLQueryItemRepresentable {
    case tops = "Tops"
    case bottoms = "Bottoms"
    case dressUp = "Dress-Up"
    case headwear = "Headwear"
    case accessories = "Accessories"
    case socks = "Socks"
    case shoes = "Shoes"
    case bags = "Bags"
    case umbrellas = "Umbrellas"
    case other = "Other"
    
    var requestParameterName: String { "category" }
    var requestParameterValue: String { rawValue }
}

enum ClothesTheme: String, CaseIterable, Codable, URLQueryItemRepresentable {
    case comfy = "Comfy"
    case everyday = "Everyday"
    case fairyTale = "Fairy Tale"
    case formal = "Formal"
    case goth = "Goth"
    case outdoorsy = "Outdoorsy"
    case party = "Party"
    case sporty = "Sporty"
    case theatrical = "Theatrical"
    case vacation = "Vacation"
    case work = "Work"
    
    var requestParameterName: String { "labeltheme" }
    var requestParameterValue: String { rawValue }
}
