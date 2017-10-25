//
//  UserNodeRequest.swift
//  GithubKit
//
//  Created by Takashi Kinjo on 24/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import Foundation

public struct UserNodeRequest: Request {
    public typealias ResponseType = Repository
    
    public static var keys = ["node", "repositories"]
    public static var totalCountKey = "totalCount"
    
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
                node(id: \\"\(id)\\") {
                    ... on User {
                        repositories(first: \(limit), orderBy: { field: STARGAZERS, direction: DESC }\(afterString)) {
                            totalCount
                            nodes {
                                ... on Repository {
                                    name
                                    description
                                    url
                                    updatedAt
                                    languages(first: 1, orderBy: { field: SIZE, direction: DESC }) {
                                        nodes {
                                            name
                                            color
                                        }
                                    }
                                    stargazers {
                                        totalCount
                                    }
                                    forks {
                                        totalCount
                                    }
                                }
                            }
                            pageInfo {
                                endCursor
                                hasNextPage
                                hasPreviousPage
                                startCursor
                            }
                        }
                    }
                }
            }"
        }
        """.components(separatedBy: .newlines).joined(separator: "")
    }
    
    public let id: String
    public let after: String?
    public let limit: Int
    
    public init(id: String, after: String?, limit: Int = 16) {
        self.id = id
        self.after = after
        self.limit = limit
    }
}

