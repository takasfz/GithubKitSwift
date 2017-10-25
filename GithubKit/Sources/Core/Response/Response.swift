//
//  Response.swift
//  GithubKit
//
//  Created by Takashi Kinjo on 23/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import Foundation

enum JsonDecodeError: Error {
    case parse(object: Any, key: String, expectedType: Any.Type)
    case cast(object: Any, expectedType: Any.Type)
}

public typealias JSON = [AnyHashable: Any]

public protocol JsonDecodable {
    init(json: JSON) throws
}

public struct Response<T: JsonDecodable> {
    public let nodes: [T]
    public let pageInfo: PageInfo
    public let totalCount: Int
    
    init(forKeys keys: [String], totalCountKey: String, json: JSON) throws {
        guard let dataJson = json["data"] as? JSON else {
            throw JsonDecodeError.parse(object: json, key: "data", expectedType: JSON.self)
        }
        let innerJson = try keys.reduce(dataJson) { (result, key) -> JSON in
            guard let dict = result[key] as? JSON else {
                throw JsonDecodeError.parse(object: result, key: key, expectedType: JSON.self)
            }
            return dict
        }
        
        guard let rawNodes = innerJson["nodes"] as? [JSON] else {
            throw JsonDecodeError.parse(object: innerJson, key: "nodes", expectedType: [JSON].self)
        }
        self.nodes = rawNodes.flatMap { try? T(json: $0) }
        
        guard let rawPageInfo = innerJson["pageInfo"] as? JSON else {
            throw JsonDecodeError.parse(object: innerJson, key: "pageInfo", expectedType: JSON.self)
        }
        self.pageInfo = try PageInfo(json: rawPageInfo)
        
        guard let totalCount = innerJson[totalCountKey] as? Int else {
            throw JsonDecodeError.parse(object: innerJson, key: totalCountKey, expectedType: Int.self)
        }
        self.totalCount = totalCount
    }
}
