//
//  HTTPTasks.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/8/22.
//

import Foundation

enum HTTPMethod {
    case get(_ queryItems: [URLQueryItem])
    case post
    case put
    case delete
    case custom(_ method: String)
    
    var methodName: String {
        switch self {
        case .get(_): return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .delete: return "DELETE"
        case .custom(let methodName): return methodName
        }
    }
}

protocol HTTPTask {
    associatedtype Response = Codable
    
    var method: HTTPMethod { get }
    var path: String? { get }
    var additionalHeaders: [String: String] { get }
    var body: Data? { get }
}

protocol HTTPDataTask: HTTPTask {
    var jsonDecoder: JSONDecoder { get }
}
