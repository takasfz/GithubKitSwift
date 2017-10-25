//
//  SearchUserRequest.swift
//  GithubKit
//
//  Created by Takashi Kinjo on 24/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import Foundation

public struct SearchUserRequest: Request {
    public typealias ResponseType = User

    public static var keys = ["search"]
    public static var totalCountKey = "userCount"
    
    public var graphQlQuery: String {
        let afterString: String = {
            if let after = after {
                return  ", after: \\\"\(after)\\\""
            }
            else {
                return ""
            }
        }()
        
        return """
        {
            "query": "{
                search(query: \\"\(query)\\", type: USER, first: \(limit)\(afterString)) {
                    pageInfo {
                        hasNextPage
                        hasPreviousPage
                        endCursor
                        startCursor
                    }
                    userCount
                    nodes {
                        ...on User {
                            id
                            bio
                            location
                            avatarUrl
                            login
                            url
                            websiteUrl
                            followers {
                                totalCount
                            }
                            repositories {
                                totalCount
                            }
                            following {
                                totalCount
                            }
                        }
                    }
                }
            }"
        }
        """.components(separatedBy: .newlines).joined(separator: "")
    }
    
    public let query: String
    public let after: String?
    public let limit: Int

    public init(query: String, after: String?, limit: Int = 16) {
        self.query = query
        self.after = after
        self.limit = limit
    }
}
