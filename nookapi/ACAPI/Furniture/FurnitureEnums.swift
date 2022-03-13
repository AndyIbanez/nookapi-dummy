//
//  FurnitureEnums.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/13/22.
//

import Foundation

enum FurnitureCategory: String, Codable {
    case wallMounted
    case ceilingDecor
    case housewares
    case miscellaneous
    
    init?(rawValue: String) {
        if rawValue.caseInsensitiveCompare("wall-mounted") == .orderedSame {
            self = .wallMounted
            return
        } else if rawValue.caseInsensitiveCompare("ceiling decor") == .orderedSame {
            self = .ceilingDecor
            return
        } else if rawValue.caseInsensitiveCompare("housewares") == .orderedSame {
            self = .housewares
            return
        } else if rawValue.caseInsensitiveCompare("miscellaneous") == .orderedSame {
            self = .miscellaneous
            return
        }
        return nil
    }
}

enum CustomKitType: String, Codable {
    case rainbowFeather
    case customizationKit
    case pumpkin
    case `none`
    
    init?(rawValue: String) {
        if rawValue.caseInsensitiveCompare("rainbow feature") == .orderedSame {
            self = .rainbowFeather
            return
        } else if rawValue.caseInsensitiveCompare("customization kit") == .orderedSame {
            self = .customizationKit
            return
        } else if rawValue.caseInsensitiveCompare("pumpkin") == .orderedSame {
            self = .pumpkin
            return
        }
        
        self = .none
    }
}
