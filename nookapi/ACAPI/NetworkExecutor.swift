//
//  NetworkExecutor.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/8/22.
//

import Foundation

enum NetworkExecutorError: Error {
    case invalidUrl
}

enum LoadingStatus {
    case loading
    case idle
    case error(_ error: Error)
}

class NetworkExecutor {
    let baseURL: URL
    let apiKey: String
    private(set) var urlSession: URLSession
    
    init(
        baseURL: URL,
        apiKey: String,
        urlSession: URLSession = URLSession(configuration: .default)
    ) {
        self.apiKey = apiKey
        self.urlSession = urlSession
        self.baseURL = baseURL
    }
    
    func execute<T: HTTPDataTask>(
        _ dataTask: T,
        configuration: URLSessionConfiguration = .default,
        timeoutInterval: TimeInterval = 60
    ) async throws -> T.Response where T.Response: Decodable {
        
        setConfiguration(configuration, for: &urlSession)
        
        let request = try buildRequest(with: dataTask, timeoutInterval: timeoutInterval)
        let (data, _) = try await urlSession.data(for: request, delegate: nil)
        let object = try dataTask.jsonDecoder.decode(T.Response.self, from: data)
        return object
    }
    
    func setConfiguration(_ configuration: URLSessionConfiguration, for session: inout URLSession) {
        session.configuration.allowsCellularAccess = configuration.allowsCellularAccess
        session.configuration.allowsConstrainedNetworkAccess = configuration.allowsConstrainedNetworkAccess
        session.configuration.allowsExpensiveNetworkAccess = configuration.allowsExpensiveNetworkAccess
        session.configuration.connectionProxyDictionary = configuration.connectionProxyDictionary
        session.configuration.httpAdditionalHeaders = configuration.httpAdditionalHeaders
        session.configuration.httpCookieAcceptPolicy = configuration.httpCookieAcceptPolicy
        session.configuration.httpCookieStorage = configuration.httpCookieStorage
        session.configuration.httpMaximumConnectionsPerHost = configuration.httpMaximumConnectionsPerHost
        session.configuration.httpShouldSetCookies = configuration.httpShouldSetCookies
        session.configuration.httpShouldUsePipelining = configuration.httpShouldUsePipelining
        session.configuration.isDiscretionary = configuration.isDiscretionary
        session.configuration.multipathServiceType = configuration.multipathServiceType
        session.configuration.networkServiceType = configuration.networkServiceType
        session.configuration.protocolClasses = configuration.protocolClasses
        session.configuration.requestCachePolicy = configuration.requestCachePolicy
        session.configuration.sessionSendsLaunchEvents = configuration.sessionSendsLaunchEvents
        session.configuration.sharedContainerIdentifier = configuration.sharedContainerIdentifier
        session.configuration.shouldUseExtendedBackgroundIdleMode = configuration.shouldUseExtendedBackgroundIdleMode
        session.configuration.timeoutIntervalForRequest = configuration.timeoutIntervalForRequest
        session.configuration.timeoutIntervalForResource = configuration.timeoutIntervalForResource
        session.configuration.tlsMaximumSupportedProtocol = configuration.tlsMaximumSupportedProtocol
        session.configuration.tlsMaximumSupportedProtocolVersion = configuration.tlsMaximumSupportedProtocolVersion
        session.configuration.tlsMinimumSupportedProtocol = configuration.tlsMinimumSupportedProtocol
        session.configuration.tlsMinimumSupportedProtocolVersion = configuration.tlsMinimumSupportedProtocolVersion
        session.configuration.urlCache = configuration.urlCache
        session.configuration.urlCredentialStorage = configuration.urlCredentialStorage
        session.configuration.waitsForConnectivity = configuration.waitsForConnectivity
    }
    
    var authorizationHeaders: [String: String] {
        [
            "X-API-KEY": apiKey
        ]
    }
    
    func buildRequest<T: HTTPTask>(with dataTask: T, timeoutInterval: TimeInterval) throws -> URLRequest {
        let url = try buildURL(with: dataTask)
        var request = URLRequest(url: url)
        request.httpMethod = dataTask.method.methodName
        request.timeoutInterval = timeoutInterval
        
        authorizationHeaders.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        
        return request
    }
    
    func buildURL<T: HTTPTask>(with dataTask: T) throws -> URL {
        let completeUrl = baseURL.appendingPathComponent(dataTask.path ?? "")
        
        guard var baseUrlComponents = URLComponents(url: completeUrl, resolvingAgainstBaseURL: true) else {
            throw NetworkExecutorError.invalidUrl
        }
        
        let queryItems: [URLQueryItem]? = {
            switch dataTask.method {
            case .get(let items): return items
            default: return nil
            }
        }()
        
        baseUrlComponents.queryItems = queryItems
        
        guard let url = baseUrlComponents.url else { throw NetworkExecutorError.invalidUrl }
        return url
    }
}
