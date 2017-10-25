//
//  Request.swift
//  GithubKit
//
//  Created by Takashi Kinjo on 24/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import Foundation

public enum HttpMethod {
    case post
    
    var value: String {
        switch self {
        case .post: return "POST"
        }
    }
}

final class RequestConfig {
    static let shared = RequestConfig()
    var token: String?

    private init() {
    }
}

public protocol Request {
    associatedtype ResponseType: JsonDecodable
    static var keys: [String] { get }
    static var totalCountKey: String { get }
    
    var baseUrl: URL { get }
    var allHttpHeaderFields: [String: String]? { get }
    
    var method: HttpMethod { get }
    var graphQlQuery: String { get }
}

extension Request {
    static func decode(with data: Data) throws -> Response<ResponseType> {
        let object = try JSONSerialization.jsonObject(with: data, options: [])
        guard let json = object as? JSON else {
            throw JsonDecodeError.cast(object: object, expectedType: JSON.self)
        }
        return try .init(forKeys: keys, totalCountKey: totalCountKey, json: json)
    }
    
    public var method: HttpMethod {
        return .post
    }
    
    public var baseUrl: URL {
        return URL(string: "https://api.github.com/graphql")!
    }
    
    public var allHttpHeaderFields: [String: String]? {
        if let token = RequestConfig.shared.token {
            return ["Authorization": "bearer \(token)"]
        }
        else {
            return nil
        }
    }
}
