//
//  RCRouterConfiguration.swift
//  RCNetworking
//
//  Created by Rupesh Chhetri on 6/29/20.
//  Copyright © 2020 com.home.rupesh. All rights reserved.
//

import Foundation

public protocol RouterConfig {
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var queryItems: QueryParams? { get }  // URL
    var bodyParameters: [String: Any]? { get }
    var timeoutInterval: TimeInterval? { get }
    var cachePolicy: URLRequest.CachePolicy? { get }
    var shouldHandleCookies: Bool { get }
}

// Defaults
extension RouterConfig {
    var method: HTTPMethod { return .get }
    var headers: HTTPHeaders { return [:] }
    var queryItems: QueryParams? { return nil }
    var bodyParameters: [String: Any]? { return nil }
    var timeoutInterval: TimeInterval? { return 10.0 }
    var cachePolicy: URLRequest.CachePolicy? { return nil }
    var shouldHandleCookies: Bool { return true }
   
    var urlComponents: URLComponents {
        var components = URLComponents(string: host)!
        //components.scheme = scheme
        //components.host = host
        components.path = path
        components.setQueryItems(with: queryItems)
        return components
    }
    
    var request: URLRequest {
        var req = URLRequest(url: urlComponents.url!)
        req.httpMethod = method.rawValue
        req.allHTTPHeaderFields = headers
        req.httpBody = getDataFromBodyParams()
        req.httpShouldHandleCookies = shouldHandleCookies
        if let _timeoutInterval = timeoutInterval {
            req.timeoutInterval = _timeoutInterval
        }
        if let _cachePolicy = cachePolicy {
            req.cachePolicy = _cachePolicy
        }
        return req
    }
    
    func getDataFromBodyParams() -> Data? {
        var data:Data?
        if let parameters = self.bodyParameters {
            do {
                if #available(iOS 11.0, *) {
                    data = try NSKeyedArchiver.archivedData(withRootObject: parameters, requiringSecureCoding: false)
                } else {
                    // Fallback on earlier versions
                    data = NSKeyedArchiver.archivedData(withRootObject: parameters)
                }
            } catch {
                
            }
        }
        return data
    }
    
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: Any]?) {
        if let queryParameters = parameters {
            var kv: [String: String] = [:]
            for (k, v) in queryParameters {
                kv[k] = String(describing: v)
            }
             self.queryItems = kv.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
    }
    
}
