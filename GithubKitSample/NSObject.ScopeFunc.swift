//
//  NSObject.ScopeFunc.swift
//  GithubKitSample
//
//  Created by Takashi Kinjo on 27/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import Foundation

// https://gist.github.com/kakajika/0bb3fd14f4afd5e5c2ec
protocol ScopeFunc {}

extension ScopeFunc {
    @inline(__always) func apply(block: (Self) -> ()) -> Self {
        block(self)
        return self
    }
}

extension NSObject: ScopeFunc {}
