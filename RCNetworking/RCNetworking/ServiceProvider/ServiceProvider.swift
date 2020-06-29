//
//  ServiceProvider.swift
//  RCNetworking
//
//  Created by Rupesh Chhetri on 6/29/20.
//  Copyright © 2020 com.home.rupesh. All rights reserved.
//

import Foundation

class ServiceProvider<T: RouterConfig> {
    
    var urlSession = URLSession.shared
    
    private var sessionTask: URLSessionTask?
    
    init() { }

    func load(service: T, completion: @escaping (CCResult<Data>) -> Void) {
        call(service.request, completion: completion)
    }

    func load<U>(service: T, decodeType: U.Type, completion: @escaping (CCResult<U>) -> Void) where U: Decodable {
        
        call(service.request) { result in
            switch result {
            case .success(let data):
                do {
                    let resp = try JSONDecoder().decode(decodeType, from: data)
                    completion(.success(resp))
                }
                catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            case .empty:
                completion(.empty)
            }
        }
    }
    
}

extension ServiceProvider {
    
    private func call(_ request: URLRequest, deliverQueue: DispatchQueue = DispatchQueue.main, completion: @escaping (CCResult<Data>) -> Void) {
        
        CCNetworkLogger.log(request: request)
        
        sessionTask = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                deliverQueue.async {
                    completion(.empty)
                }
                return
            }
            
            CCNetworkLogger.log(response: httpResponse)
            
            if case 200...299 = httpResponse.statusCode {
                
                self.parseSuccessResponse(httpResponse, data: data, completion: completion)
                
            } else {
                
                self.parseFailureResponse(httpResponse, error: error, completion: completion)
                
            }
            
        })
        sessionTask?.resume()
    }
    
    func parseSuccessResponse(_ response: HTTPURLResponse, data: Data?, completion: @escaping (CCResult<Data>) -> Void) {
        
        if let data = data {
            DispatchQueue.main.async {
                completion(.success(data))
            }
        } else {
            DispatchQueue.main.async {
                completion(.empty)
            }
        }
    }
    func parseFailureResponse(_ response: HTTPURLResponse, error: Error?, completion: @escaping (CCResult<Data>) -> Void) {
        //let networkResponseStatus = CCNetworkError(httpStatusCode: response.statusCode)
        if let error = error {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        } else {
            DispatchQueue.main.async {
                completion(.empty)
            }
        }
        
    }
    
    func cancel() {
        sessionTask?.cancel()
    }
    
    func stopAllTasks() {
        
        DispatchQueue.global(qos: .default).async {
            self.urlSession.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
                dataTasks.forEach {
                    print("00--00 stopping dataTasks")
                    $0.cancel()
                }
                uploadTasks.forEach {
                    print("00--00 stopping uploadTasks")
                    $0.cancel()
                }
                downloadTasks.forEach {
                    print("00--00 stopping downloadTasks")
                    $0.cancel()
                }
            }
        }
    }
    
}
