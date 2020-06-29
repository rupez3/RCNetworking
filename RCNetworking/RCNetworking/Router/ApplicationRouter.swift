//
//  ApplicationRouter.swift
//  RCNetworking
//
//  Created by Rupesh Chhetri on 6/29/20.
//  Copyright © 2020 com.home.rupesh. All rights reserved.
//

import Foundation

enum NewApplicationRouter {
    
    case configuration(queryParams: QueryParams)
    case techBuffer(queryParams: QueryParams)
    
}

extension NewApplicationRouter: RouterConfig {
    
    var host: String {
        return "https://google.com"
    }
    
    var method: HTTPMethod {
        switch self {
        case .configuration(_):
            return .get
        case .techBuffer:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .configuration(_):
            return "/me/configuration"
        case .techBuffer:
            return "/me/techStatus"
        }
    }
    
    var headers: HTTPHeaders {
        //var _headers = CCAppHeaders.tech360Headers()
        return [:]
    }
    
    var queryItems: QueryParams? {
        switch self {
        case .configuration(let configParam):
            return configParam
        case .techBuffer(let params):
            return params
        }
    }
    
    var bodyParameters: [String : Any]? {
        return nil
    }
    
    var timeoutInterval: TimeInterval? {
        return 15.0
    }
    
}

/*
extension NewApplicationRouter {
    
    fileprivate var microServicesPath: MicroserviceContent? {
        return ConfigurationManagerMiddleware.shared.properties?.microservices.application
    }
    
}

extension NewApplicationRouter: RouterConfig {
    
    var host: String {
        return microServicesPath?.baseUrl ?? ""
    }
    
    var method: HTTPMethod {
        switch self {
        case .configuration(_):
            return .get
        case .techBuffer:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .configuration(_):
            return microServicesPath?.search(forKey: .CONFIGURATION)?.value ?? ""
        case .techBuffer:
            return microServicesPath?.search(forKey: .CPEBUFFER)?.value ?? ""
        }
    }
    
    var headers: HTTPHeaders {
        
        var _headers = CCAppHeaders.tech360Headers()
        
        var headerInfo: String?
        
        switch self {
        case .configuration(_):
            headerInfo = microServicesPath?.search(forKey: .CONFIGURATION)?.xVersion
        case .techBuffer:
            headerInfo = microServicesPath?.search(forKey: .CPEBUFFER)?.xVersion
        }
        
        if let xVersion = headerInfo {
            _headers[HTTPHeaderKey.CustomKey.version.rawValue] = xVersion
        }
        
        return _headers
        
    }
    
    var queryItems: QueryParams? {
        switch self {
        case .configuration(let configParam):
            return configParam
        case .techBuffer(let params):
            return params
        }
    }
    
    var bodyParameters: [String : Any]? {
        return nil
    }
    
    var timeoutInterval: TimeInterval? {
        
        let defaultTimeoutString = "\(String(NetworkCommon.shared.defaultTimeout))"
        
        switch self {
        case .configuration(_):
            return Double(microServicesPath?.search(forKey: .CONFIGURATION)?.timeout ?? defaultTimeoutString)!
        case .techBuffer:
            return Double(microServicesPath?.search(forKey: .CPEBUFFER)?.timeout ?? defaultTimeoutString)!
        }
    }
    
}
*/
