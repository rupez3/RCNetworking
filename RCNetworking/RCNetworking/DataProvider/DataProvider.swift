//
//  DataProvider.swift
//  RCNetworking
//
//  Created by Rupesh Chhetri on 6/29/20.
//  Copyright © 2020 com.home.rupesh. All rights reserved.
//

import Foundation

protocol DataProvider {
    
    associatedtype Response: Decodable
    associatedtype Router: RouterConfig
    
    var provider: ServiceProvider<Router> { get }
    var additionalHeaders: HTTPHeaders? { get }
    var queryParam: [String: String]? { get }
    var bodyParam: [String: Any]? { get }
    var mockFilename: String? { get }
    
    func loadData(_ completion: @escaping (CCResult<Response>) -> Void)
    
    func loadMockData(_ completion: @escaping (CCResult<Response>) -> Void)
    
}

extension DataProvider {
    var additionalHeaders: HTTPHeaders? { return nil }
    var queryParam: [String: String]? { return nil }
    var bodyParam: [String: Any]? { return nil }
    var mockFilename: String? { return nil }
    func loadMockData(_ completion: @escaping (CCResult<Response>) -> Void) {}
    
}
