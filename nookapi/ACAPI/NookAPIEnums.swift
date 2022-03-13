//
//  NookAPIEnums.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/7/22.
//

import Foundation

enum GameVersion: String, CaseIterable, Codable {
    case v1_0_0   = "1.0.0"
    case v1_1_0   = "1.1.0"
    case v1_1_1   = "1.1.1"
    case v1_1_1_a = "1.1.1a"
    case v1_1_2   = "1.1.2"
    case v1_1_3   = "1.1.3"
    case v1_1_4   = "1.1.4"
    case v1_2_0   = "1.2.0"
    case v1_2_1   = "1.2.1"
    case v1_3_0   = "1.3.0"
    case v1_3_1   = "1.3.1"
    case v1_4_0   = "1.4.0"
    case v1_4_1   = "1.4.1"
    case v1_5_0   = "1.5.0"
    case v1_5_1   = "1.5.1"
    case v1_6_0   = "1.6.0"
    case v1_7_0   = "1.7.0"
    case v1_8_0   = "1.8.0"
    case v1_9_0   = "1.9.0"
    case v1_10_0  = "1.10.0"
    case v1_11_0  = "1.11.0"
    case v1_11_1  = "1.11.1"
    case v2_0_0   = "2.0.0"
    case v2_0_1   = "2.0.1"
    case v2_0_2   = "2.0.2"
    case v2_0_3   = "2.0.3"
    case v2_0_4   = "2.0.4"
}

enum ItemColor: String, CaseIterable, Codable, URLQueryItemRepresentable {
    case aqua = "Aqua"
    case beige = "Beige"
    case black = "Black"
    case blue = "Blue"
    case brown = "Brown"
    case colorful = "Colorful"
    case gray = "Gray"
    case green = "Green"
    case orange = "Orange"
    case pink = "Pink"
    case purple = "Purple"
    case red = "Red"
    case white = "White"
    case yellow = "Yellow"
    
    var requestParameterName: String { "color" }
    var requestParameterValue: String { rawValue }
}

enum ItemStyle: String, CaseIterable, Codable, URLQueryItemRepresentable {
    case active = "Active"
    case cool = "Cool"
    case cute = "Cute"
    case elegant = "Elegant"
    case gorgeous = "Gorgeous"
    case simple = "Simple"
    
    var requestParameterName: String { "style" }
    var requestParameterValue: String { rawValue }
}

enum ItemCurrency: String, Codable {
    case bells = "Bells"
    case poki = "Poki"
    case heartCrystals = "Heart Crystals"
    case nookMiles = "Nook Miles"
    case nookPoints = "Nook Points"
}

enum Seasonality: String, Codable {
    case allYear
    case winter
    case spring
    case summer
    case fall
    case `none`
    
    init?(rawValue: String) {
        if rawValue.caseInsensitiveCompare("all year") == .orderedSame {
            self = .allYear
            return
        } else if rawValue.caseInsensitiveCompare("winter") == .orderedSame {
            self = .winter
            return
        } else if rawValue.caseInsensitiveCompare("spring") == .orderedSame {
            self = .spring
            return
        } else if rawValue.caseInsensitiveCompare("summer") == .orderedSame {
            self = .summer
            return
        } else if rawValue.caseInsensitiveCompare("fall") == .orderedSame {
            self = .fall
            return
        }
        self = .none
    }
}
