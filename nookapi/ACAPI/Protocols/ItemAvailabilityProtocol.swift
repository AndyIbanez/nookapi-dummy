//
//  ItemAvailabilityProtocol.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/9/22.
//

import Foundation

protocol ItemAvailabilityProtocol: Equatable {
    var from: String { get }
    var note: String { get }
}
