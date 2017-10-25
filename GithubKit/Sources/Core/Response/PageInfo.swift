//
//  PageInfo.swift
//  GithubKit
//
//  Created by Takashi Kinjo on 23/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import Foundation

public struct PageInfo: JsonDecodable {
    public let hasNextPage: Bool
    public let hasPreviousPage: Bool
    public let startCursor: String?
    public let endCursor: String?

    public init(json: JSON) throws {
        guard let hasNextPage = json["hasNextPage"] as? Bool else {
            throw JsonDecodeError.parse(object: json, key: "hasNextPage", expectedType: Bool.self)
        }
        self.hasNextPage = hasNextPage
        
        guard let hasPreviousPage = json["hasPreviousPage"] as? Bool else {
            throw JsonDecodeError.parse(object: json, key: "hasPreviousPage", expectedType: Bool.self)
        }
        self.hasPreviousPage = hasPreviousPage
        
        self.startCursor = json["startCursor"] as? String
        self.endCursor = json["endCursor"] as? String
    }
}
