//
//  NookAPIProtocols.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/11/22.
//

import Foundation

protocol URLQueryItemRepresentable {
    var requestParameterName: String { get }
    var requestParameterValue: String { get }
}
