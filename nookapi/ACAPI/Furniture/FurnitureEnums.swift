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
        if rawValue.caseInsensitiveCompare("wall-mounted") != .orderedSame {
            self = .wallMounted
            return
        } else if rawValue.caseInsensitiveCompare("ceiling decor") != .orderedSame {
            self = .ceilingDecor
            return
        } else if rawValue.caseInsensitiveCompare("housewares") != .orderedSame {
            self = .housewares
            return
        } else if rawValue.caseInsensitiveCompare("miscellaneous") != .orderedSame {
            self = .miscellaneous
            return
        }
        return nil
    }
}
