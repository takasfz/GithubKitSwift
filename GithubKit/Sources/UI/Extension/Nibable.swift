//
//  Nibable.swift
//  GithubKit
//
//  Created by Takashi Kinjo on 26/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import UIKit

public protocol Nibable: NSObjectProtocol {
    static var nib: UINib { get }
    static var reuseIdentifier: String { get }
    static func makeFromNib() -> Self
}

extension Nibable {
    public static var nib: UINib {
        return UINib(nibName: className, bundle: Bundle(for: Self.self))
    }
    
    public static var reuseIdentifier: String {
        return className
    }
    
    public static func makeFromNib() -> Self {
        return nib.instantiate(withOwner: nil, options: nil).first as! Self
    }
}
