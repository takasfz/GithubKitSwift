//
//  NSObjectProtocol.extension.swift
//  GithubKit
//
//  Created by Takashi Kinjo on 26/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    public static var className: String {
        return String(describing: Self.self)
    }
}
