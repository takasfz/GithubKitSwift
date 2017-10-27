//
//  Int.truncateString.swift
//  GithubKit
//
//  Created by Takashi Kinjo on 26/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import Foundation

extension Int {
    var truncateString: String {
        switch self {
        case 0...999:
            return "\(self)"
        case 1000...999999:
            return "\(String(format: "%.1f", Double(self) / 1000))K"
        default:
            return "\(String(format: "%.1f", Double(self) / 1000000))M"
        }
    }
}
