//
//  CCAppHeaders.swift
//  RCNetworking
//
//  Created by Rupesh Chhetri on 6/29/20.
//  Copyright © 2020 com.home.rupesh. All rights reserved.
//

import Foundation
//import Tech360Common

/*
class CCAppHeaders {
    
    class func tech360Headers() -> HTTPHeaders {
        
        var allHeaders: HTTPHeaders = [:]
        
        var headers: [HTTPHeader] = []
        
        let authHeaders = self.authHeaders()
        
        headers.append(contentsOf: authHeaders)
        
        let uuid = UUID().uuidString
        let iosVersion = UIDevice.current.systemVersion
        let appVersion = "\(CoreUtilities.getBuildNumber()).\(CoreUtilities.getVersionNumber())"
        let isVirtualTech = ProfileHandler.shared.currentUserProfile?.userFlagsModel.isVirtualTech.description ?? ""
        let currentScreen = StateUIAppScreen.shared.getCurrentScreen().rawValue
        let isAccountView = String(AccountViewMode.shared.isActivated)
        
        headers.append(.init(key: .customKey(key: .callRef), value: .other(value: uuid)))
        headers.append(.init(key: .customKey(key: .iosVersion), value: .other(value: iosVersion)))
        headers.append(.init(key: .customKey(key: .appVersion), value: .other(value: appVersion)))
        headers.append(.init(key: .customKey(key: .isVirtualTech), value: .other(value: isVirtualTech)))
        headers.append(.init(key: .customKey(key: .pageName), value: .other(value: currentScreen)))
        headers.append(.init(key: .customKey(key: .isAccountView), value: .other(value: isAccountView)))
        
        let autoNoteHeaders = self.autoNoteHeaders()
        headers.append(contentsOf: autoNoteHeaders)
        
        // Convert to HTTPHeaders
        headers.forEach({ allHeaders[$0.key.name] = $0.value.name})
        
        return allHeaders
        
    }
    
}

extension CCAppHeaders {
    
    fileprivate static func authHeaders() -> [HTTPHeader] {
        
        var headers: [HTTPHeader] = []
        
        if let accesstoken = KeychainWrapper.sharedInstance.getKeyChainAccessForKey(tokenTypes.access_token.rawValue) as? String {
            
            let authtoken_hdr = "Bearer \(accesstoken)"
            
            headers.append(.init(key: .commonKey(key: .authorization), value: .other(value: authtoken_hdr)))
            
        } else {
            writelog("no auth token")
        }
        
        if let sessionToken = KeychainWrapper.sharedInstance.getKeyChainAccessForKey(tokenTypes.session_token.rawValue) as? String {
            
            headers.append(.init(key: .customKey(key: .sessionToken), value: .other(value: sessionToken)))
            
        } else {
            writelog("no sessionToken token")
        }
        
        return headers
    }
    
    fileprivate static func autoNoteHeaders() -> [HTTPHeader] {
        
        var headers: [HTTPHeader] = []
        
        if let autoNotesHeaders = AppUtility.sharedInstance.autoNotesHeaders {
            let scheduleDate = autoNotesHeaders.scheduleDate
            let jobId = autoNotesHeaders.jobId
            let acctNum = autoNotesHeaders.accountNumber
            let woNum = autoNotesHeaders.workOrderNumber
            let jobClassCd = autoNotesHeaders.jobClassCd
            
            headers.append(.init(key: .customKey(key: .scheduleDate), value: .other(value: scheduleDate)))
            headers.append(.init(key: .customKey(key: .jobId), value: .other(value: jobId)))
            headers.append(.init(key: .customKey(key: .accountNumber), value: .other(value: acctNum)))
            headers.append(.init(key: .customKey(key: .woNumber), value: .other(value: woNum)))
            headers.append(.init(key: .customKey(key: .jobClassId), value: .other(value: jobClassCd)))
        }
        
        return headers
    }
    
}

*/
