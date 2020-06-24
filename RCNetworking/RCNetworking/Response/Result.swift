//
//  Result.swift
//  RCNetworking
//
//  Created by Rupesh Chhetri on 6/23/20.
//  Copyright © 2020 com.home.rupesh. All rights reserved.
//

import Foundation

enum Result<T, E> where E: Error {
    
    case success(T)
    case failure(E)

}
