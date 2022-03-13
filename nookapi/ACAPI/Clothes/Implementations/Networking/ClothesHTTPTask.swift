//
//  ClothesHTTPTask.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/11/22.
//

import Foundation

struct ClothesRequestParameters {
    var category: ClothesCategory?
    var color: ItemColor?
    var style: ItemStyle?
    var labelTheme: ClothesTheme?
    var excludeDetails: Bool?
}

struct ClothesHTTPTask: HTTPDataTask {
    typealias Response = Array<ClothesCodable>
    
    var method: HTTPMethod
    let path: String? = "/nh/clothing"
    let additionalHeaders: [String : String] = [:]
    let body: Data? = nil
    
    var jsonDecoder: JSONDecoder = JSONDecoder()
    
    init(parameters: ClothesRequestParameters) {
        let queryItems = buildQueryItems(with: parameters)
        self.method = .get(queryItems)
    }
}

fileprivate func buildQueryItems(with parameters: ClothesRequestParameters) -> [URLQueryItem] {
    var requestQueryItems: [URLQueryItem] = []
    if let category = parameters.category {
        requestQueryItems.append(
            URLQueryItem(name: category.requestParameterName, value: category.requestParameterValue)
        )
    }
    
    if let color = parameters.color {
        requestQueryItems.append(
            URLQueryItem(name: color.requestParameterName, value: color.requestParameterValue)
        )
    }
    
    if let style = parameters.style {
        requestQueryItems.append(
            URLQueryItem(name: style.requestParameterName, value: style.requestParameterValue)
        )
    }
    
    if let labelTheme = parameters.labelTheme {
        requestQueryItems.append(
            URLQueryItem(name: labelTheme.requestParameterName, value: labelTheme.requestParameterValue)
        )
    }
    
    if let excludeDetails = parameters.excludeDetails {
        let excludeDetailsString = excludeDetails ? "true" : "false"
        requestQueryItems.append(URLQueryItem(name: "excludedetails", value: excludeDetailsString))
    }
    
    return requestQueryItems
}
