//
//  HTTPMethod.swift
//  RCNetworking
//
//  Created by Rupesh Chhetri on 6/23/20.
//  Copyright © 2020 com.home.rupesh. All rights reserved.
//

import Foundation

/// Pre-typed strings for use with NetworkRequest.httpMethod (or URLRequest.httpMethod)
public enum HTTPMethod: String {
    case get        = "GET"
    case post       = "POST"
    case put        = "PUT"
    case delete     = "DELETE"
    case patch      = "PATCH"
    case head       = "HEAD"
    case trace      = "TRACE"
    case connect    = "CONNECT"
    case options    = "OPTIONS"
}

