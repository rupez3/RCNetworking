//
//  Result.swift
//  RCNetworking
//
//  Created by Rupesh Chhetri on 6/23/20.
//  Copyright © 2020 com.home.rupesh. All rights reserved.
//

import Foundation

/*
 enum NetworkResult<T, E> where E: Error {
 case success(T)
 case failure(E)
 case empty
 }
 */

public class BaseModel<T:Decodable>: Decodable {
     let data: T
}

public struct ExampleModel: Decodable {
    var modelName: String = ""
    var modelImage: String?
    var modelType: String?
}

enum CCResult<T> {
    case success(T)
    case failure(Error)
    case empty
}

// Helper to load local file
func loadLocalFile<T: Decodable>(_ filename: String, as type: T.Type, completion: @escaping (CCResult<T>) -> Void) {
    
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        completion(.empty)
        return
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        completion(.empty)
        return
    }
    
    do {
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: data)
        completion(.success(result))
    } catch {
        completion(.failure(error))
    }
    
}

