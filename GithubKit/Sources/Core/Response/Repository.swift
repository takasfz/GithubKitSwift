//
//  Repository.swift
//  GithubKit
//
//  Created by Takashi Kinjo on 24/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import Foundation

public struct Repository: JsonDecodable {
    public struct Language {
        let name: String
        let color: String
    }
    
    public let name: String
    public let introduction: String?
    public let language: Language?
    public let stargazerCount: Int
    public let forkCount: Int
    public let url: URL
    public let updatedAt: Date
    
    public init(json: JSON) throws {
        guard let name = json["name"] as? String else {
            throw JsonDecodeError.parse(object: json, key: "name", expectedType: String.self)
        }
        self.name = name
        
        self.introduction = json["introduction"] as? String
        
        if
            let languages = json["languages"] as? JSON,
            let nodes = languages["nodes"] as? [JSON],
            let name = nodes.first?["name"] as? String,
            let color = nodes.first?["color"] as? String
        {
            self.language = Language(name: name, color: color)
        }
        else {
            self.language = nil
        }
        
        self.stargazerCount = try TotalCountWrapper(forKey: "stargazers", json: json).value
        self.forkCount = try TotalCountWrapper(forKey: "forks", json: json).value
        self.url = try URLWrapper(forKey: "url", json: json).value
        
        guard let rawUpdatedAt = json["updatedAt"] as? String else {
            throw JsonDecodeError.parse(object: json, key: "updatedAt", expectedType: String.self)
        }
        guard let updatedAt = DateFormatter.ISO8601.date(from: rawUpdatedAt) else {
            throw JsonDecodeError.parse(object: json, key: "updatedAt", expectedType: Date.self)
        }
        self.updatedAt = updatedAt
    }
}
