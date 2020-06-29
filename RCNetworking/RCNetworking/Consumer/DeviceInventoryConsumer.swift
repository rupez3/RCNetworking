//
//  DeviceInventoryConsumer.swift
//  RCNetworking
//
//  Created by Rupesh Chhetri on 6/29/20.
//  Copyright © 2020 com.home.rupesh. All rights reserved.
//

import Foundation

struct DeviceInventoryConsumer: DataProvider {
    //BaseModel<[TechBuffer]>
    typealias Response = BaseModel<ExampleModel>
    
    typealias Router = NewApplicationRouter
    
    var provider: ServiceProvider<Router> {
        return ServiceProvider<Router>()
    }

    var api: Router

    init(api: Router) {
        self.api = api
        
    }
    
    var mockFilename: String? {
        return "buffer-v4_WifiReady.json"
    }

    func loadData(_ completion: @escaping (CCResult<Response>) -> Void) {
        
        provider.load(service: api, decodeType: Response.self, completion: completion)
        
    }
    
    func loadMockData(_ completion: @escaping (CCResult<Response>) -> Void) {
        loadLocalFile(mockFilename!, as: Response.self, completion: completion)
        
    }
    
}
