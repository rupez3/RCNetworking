//
//  TechStatusRouter.swift
//  RCNetworking
//
//  Created by Rupesh Chhetri on 6/29/20.
//  Copyright © 2020 com.home.rupesh. All rights reserved.
//

import Foundation

enum NewTechStatusRouter {
    
    case techStatus

    case updateTechStatus(techstatus: String, workOrderNumber: String?, acctNum: String, isPhtV4:Bool, eventID:String, isUpdateOnGeoFenceError: Bool, jobLocation: [String:String], techLocation: [String:String])
    
}

/*

extension NewTechStatusRouter: RouterConfig {
    
    fileprivate var microServicesPath: MicroserviceContent? {
        return ConfigurationManagerMiddleware.shared.properties?.microservices.techStatus
    }
    
    var host: String {
        return microServicesPath?.baseUrl ?? ""
    }
    
    var bodyParameters: [String : Any]? {
        return nil
    }

    var method: HTTPMethod {
        switch self {
        case .techStatus:
            return .get
        case .updateTechStatus(_,_,_,_,_,_,_,_):
            return .put
        }
    }

    var path: String {
        switch self {
        case .techStatus:
            return microServicesPath?.search(forKey: .GET_TECH_STATUS)?.value ?? ""
        case .updateTechStatus(_,_,_,_,_,_,_,_):
            return microServicesPath?.search(forKey: .UPDATE_TECH_STATUS)!.value ?? ""
        }
    }

    var headers: HTTPHeaders {
        
        var _headers = CCAppHeaders.tech360Headers()
        
        var headerInfo: String?
        
        switch self {
        case .techStatus:
            headerInfo = microServicesPath?.search(forKey: .GET_TECH_STATUS)?.xVersion
        case .updateTechStatus(_,_,_,_,_,_,_,_):
            headerInfo = microServicesPath?.search(forKey: .UPDATE_TECH_STATUS)?.xVersion
        }
        
        if let xVersion = headerInfo {
            _headers[HTTPHeaderKey.CustomKey.version.rawValue] = xVersion
        }
        
        return _headers
        
    }
    
    var timeoutInterval: TimeInterval? {

        let defaultTimeoutString = "\(String(NetworkCommon.shared.defaultTimeout))"

        switch self {
        case .techStatus:
            return Double(microServicesPath?.search(forKey: .GET_TECH_STATUS)?.timeout ?? defaultTimeoutString)!
        case .updateTechStatus(_,_,_,_,_,_,_,_):
            return Double(microServicesPath?.search(forKey: .UPDATE_TECH_STATUS)?.timeout ?? defaultTimeoutString)!
        }
    }

    // FIXME:- need to use QueryParams type
    var queryItems: [String: Any]? {
        switch self {
        case .techStatus:
            return nil
        case .updateTechStatus(let techstatus, let workOrderNumber, let acctNum, let phtV4,let eventID, let isUpdateOnGeoFenceError, let jobLocation, let techLocation):
            if let woNum = workOrderNumber {
                return [
                    Constants.UpdateTechStatusParams.techStatus.rawValue: techstatus as Any,
                    Constants.UpdateTechStatusParams.workOrderNumber.rawValue:woNum as Any,
                    Constants.UpdateTechStatusParams.accountNumber.rawValue: acctNum as Any,
                    Constants.UpdateTechStatusParams.phtV4.rawValue: phtV4 as Any,
                    Constants.UpdateTechStatusParams.isUpdateOnGeoFenceError.rawValue: isUpdateOnGeoFenceError as Any,
                    Constants.UpdateTechStatusParams.jobLocation.rawValue: jobLocation as Any,
                    Constants.UpdateTechStatusParams.techLocation.rawValue: techLocation as Any
                ]
            }
            return [Constants.UpdateTechStatusParams.techStatus.rawValue: techstatus,Constants.UpdateTechStatusParams.eventID.rawValue:eventID]
        }
    }
    
}

 */
