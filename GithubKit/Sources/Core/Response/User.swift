//
//  User.swift
//  GithubKit
//
//  Created by Takashi Kinjo on 24/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import Foundation

public struct User: JsonDecodable {
    public let id: String
    public let avatarUrl: URL
    public let followerCount: Int
    public let followingCount: Int
    public let login: String
    public let repositoryCount: Int
    public let url: URL
    public let websiteUrl: URL?
    public let location: String?
    public let bio: String?
    
    public init(json: JSON) throws {
        guard let id = json["id"] as? String else {
            throw JsonDecodeError.parse(object: json, key: "id", expectedType: String.self)
        }
        self.id = id
        
        self.avatarUrl = try URLWrapper(forKey: "avatarUrl", json: json).value
        self.followerCount = try TotalCountWrapper(forKey: "followers", json: json).value
        self.followingCount = try TotalCountWrapper(forKey: "following", json: json).value
        self.repositoryCount = try TotalCountWrapper(forKey: "repositories", json: json).value
        
        guard let login = json["login"] as? String else {
            throw JsonDecodeError.parse(object: json, key: "login", expectedType: String.self)
        }
        self.login = login
        
        self.url = try URLWrapper(forKey: "url", json: json).value
        self.websiteUrl = try? URLWrapper(forKey: "websiteUrl", json: json).value
        self.location = json["location"] as? String
        self.bio = json["bio"] as? String
    }
}
