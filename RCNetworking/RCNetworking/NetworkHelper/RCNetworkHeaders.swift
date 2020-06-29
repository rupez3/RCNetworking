//
//  RCNetworkHeaders.swift
//  RCNetworking
//
//  Created by Rupesh Chhetri on 6/29/20.
//  Copyright © 2020 com.home.rupesh. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]
public typealias QueryParams = [String: String]
public typealias BodyParams = [String: Any?]

public struct HTTPHeader: Hashable {
    let key: HTTPHeaderKey
    let value: HTTPHeaderValue
}

public struct QueryParam {
    let key: String
    let value: String
}

public struct BodyParam {
    let key: String
    let value: Any?
}

/// Pre-typed strings for use with formatting headers
public enum HTTPHeaderKey: Hashable {

    public enum CommonKey: String, Hashable {
        case accept = "Accept"
        case acceptEncoding = "Accept-Encoding"
        case authorization = "Authorization"
        case contentType = "Content-Type"
        case acceptCharset = "Accept-Charset"
        case acceptDatetime = "Accept-Datetime"
        case acceptLanguage = "Accept-Language"
        case cacheControl = "Cache-Control"
        case date = "Date"
        case ifMatch = "If-Match"
        case ifModifiedSince = "If-Modified-Since"
        case ifNoneMatch = "If-None-Match"
        case ifRange = "If-Range"
        case ifUnmodifiedSince = "If-Unmodified-Since"
        case maxForwards = "Max-Forwards"
        case pragma = "Pragma"
        case proxyAuthorization = "Proxy-Authorization"
        case proxyConnection = "Proxy-Connection"
        case range = "Range"
        case referer = "Referer"
        case TE = "TE"
        case upgrade = "Upgrade"
        case userAgent = "User-Agent"
        case via = "Via"
        case warning = "Warning"
        case frontEndHttps = "Front-End-Https"
        case cookie = "Cookie"
        case expect = "Expect"
    }
    
    public enum CustomKey: String, Hashable {
        case version = "X-Version"
        case callRef = "X-callref"
        case iosVersion = "X-ios-version"
        case appVersion = "X-app-version"
        case isVirtualTech = "X-is-virtual-tech"
        case scheduleDate = "X-ScheduleDate"
        case jobId = "X-JobId"
        case accountNumber = "X-AccountNumber"
        case woNumber = "X-WorkOrderNumber"
        case jobClassId = "X-JobClassCd"
        case sessionToken = "session_token"
        case pageName = "X-PageName"
        case isAccountView = "X-isAccountView"
    }
    
    case commonKey(key: CommonKey)
    case customKey(key: CustomKey)
    case other(key: String)
    
    var name: String {
        switch self {
        case .commonKey(key: let x): return x.rawValue
        case .customKey(key: let y): return y.rawValue
        case .other(key: let z): return z
        }
    }
    
}

public enum HTTPHeaderValue: Hashable {
    
    public enum CommonContentType: String, Hashable {
        case javascript = "application/javascript"
        case json = "application/json"
        case octetStream = "application/octet-stream"
        case xFontWoff = "application/x-font-woff"
        case xml = "application/xml"
        case audioMp4 = "audio/mp4"
        case ogg = "audio/ogg"
        case opentype = "font/opentype"
        case svgXml = "image/svg+xml"
        case webp = "image/webp"
        case xIcon = "image/x-icon"
        case cacheManifest = "text/cache-manifest"
        case vCard = "text/v-card"
        case vtt = "text/vtt"
        case videoMp4 = "video/mp4"
        case videoOgg = "video/ogg"
        case webm = "video/webm"
        case xFlv = "video/x-flv"
        case png = "image/png"
        case jpeg = "image/jpeg"
        case bmp = "image/bmp"
        case css = "text/css"
        case gif = "image/gif"
        case html = "text/html"
        case audioMpeg = "audio/mpeg"
        case videoMpeg = "video/mpeg"
        case pdf = "application/pdf"
        case quicktime = "video/quicktime"
        case rtf = "application/rtf"
        case tiff = "image/tiff"
        case plain = "text/plain"
        case zip = "application/zip"
        case plist = "application/x-plist"
    }
    
    case contentType(type: CommonContentType)
    case other(value: String)
    
    var name: String {
        switch self {
        case .contentType(type: let x): return x.rawValue
        case .other(value: let y): return y
        }
    }
    
}
