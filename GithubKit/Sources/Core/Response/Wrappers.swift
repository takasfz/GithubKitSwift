//
//  Wrappers.swift
//  GithubKit
//
//  Created by Takashi Kinjo on 24/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import Foundation

struct URLWrapper {
    let value: URL
    
    init(forKey key: String, json: JSON) throws {
        guard let value = (json[key] as? String).flatMap(URL.init) else {
            throw JsonDecodeError.parse(object: json, key: key, expectedType: URL.self)
        }
        self.value = value
    }
}

struct TotalCountWrapper {
    let value: Int
    
    init(forKey key: String, json: JSON) throws {
        guard let value = (json[key] as? JSON).flatMap({ $0["totalCount"] as? Int }) else {
            throw JsonDecodeError.parse(object: json, key: key, expectedType: Int.self)
        }
        self.value = value
    }
}
