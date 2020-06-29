//
//  ConfigurationConsumer.swift
//  RCNetworking
//
//  Created by Rupesh Chhetri on 6/29/20.
//  Copyright © 2020 com.home.rupesh. All rights reserved.
//

import Foundation

struct ConfigurationConsumer: DataProvider {
    
    // Configuration
    typealias Response = ExampleModel
    
    typealias Router = NewApplicationRouter
    
    var provider: ServiceProvider<Router> {
        return ServiceProvider<Router>()
    }
    
    var api: Router
    
    init(api: Router) {
        self.api = api
    }
    
    func loadData(_ completion: @escaping (CCResult<Response>) -> Void) {
        provider.load(service: api, decodeType: Response.self, completion: completion)
    }
    
}

