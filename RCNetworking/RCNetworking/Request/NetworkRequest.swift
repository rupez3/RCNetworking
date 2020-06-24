//
//  Request.swift
//  RCNetworking
//
//  Created by Rupesh Chhetri on 6/23/20.
//  Copyright © 2020 com.home.rupesh. All rights reserved.
//

import Foundation

public protocol EndPointType {
    var hostName: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem]? { get }
    var timeoutInterval: TimeInterval? { get }
    var encoding: ParameterEncoding { get }
    
    var cachePolicy: URLRequest.CachePolicy? { get }
    
    var mockFileName: String? { get }
}

extension EndPointType {
    
    var urlComponents: URLComponents {
        let base: String = hostName
        var component = URLComponents(string: base)!
        component.path = path
        component.queryItems = queryItems
        return component
    }
    
    var request: URLRequest {
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        if let _timeoutInterval = timeoutInterval {
            request.timeoutInterval = _timeoutInterval
        }
        if let _cachePolicy = cachePolicy {
            request.cachePolicy = _cachePolicy
        }
        request.httpShouldHandleCookies = true
        return request
    }
    
}
