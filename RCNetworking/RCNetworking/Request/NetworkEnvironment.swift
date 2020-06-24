//
//  NetworkEnvironment.swift
//  RCNetworking
//
//  Created by Rupesh Chhetri on 6/23/20.
//  Copyright © 2020 com.home.rupesh. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case int
    case stage
    case prod
    case alpha
    case mdm
    case mdmBeta
    case apperian
    
    func getHostname() -> String? {
        switch self {
        case .qa:
            return nil
        default:
            return nil
        }
    }
}
