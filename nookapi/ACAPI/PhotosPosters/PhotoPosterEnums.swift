//
//  PhotoPosterEnums.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/13/22.
//

import Foundation

enum PhotoPosterCategory: String, Codable {
    case poster = "Posters"
    case photo = "Photos"
}

enum PhotoPosterBodyPart: String, Codable {
    case frame = "Frame"
    case `none`
    
    init?(rawValue: String) {
        if rawValue.caseInsensitiveCompare("frame") == .orderedSame {
            self = .frame
            return
        }
        self = .none
    }
}
