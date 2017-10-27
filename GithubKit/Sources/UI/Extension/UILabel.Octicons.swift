//
//  UILabel.Octicons.swift
//  GithubKit
//
//  Created by Takashi Kinjo on 26/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import Foundation
import SwiftIconFont

extension UILabel {
    enum OcticonIcon: String {
        case repo = "repo"
        case repoForked = "repo-forked"
        case star = "star"
        case location = "location"
        case eye = "eye"
        case organization = "organization"
    }
    
    func setText(as icon: OcticonIcon, ofSize: CGFloat = 16) {
        font = .icon(from: .Octicon, ofSize: ofSize)
        text = .fontOcticon(icon.rawValue)
    }
}
