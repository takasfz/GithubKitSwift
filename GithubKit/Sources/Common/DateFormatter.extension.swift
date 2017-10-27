//
//  DateFormatter.extension.swift
//  GithubKit
//
//  Created by Takashi Kinjo on 24/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let `default` = DateFormatter().apply {
        $0.locale = Locale(identifier: "en_US_POSIX")
        $0.timeZone = TimeZone(secondsFromGMT: 0)
        $0.dateFormat = "dd MMMM yyyy"
    }

    static let ISO8601 = DateFormatter().apply {
        $0.locale = Locale(identifier: "en_US_POSIX")
        $0.timeZone = TimeZone(secondsFromGMT: 0)
        $0.dateFormat = "yyyy-MM-dd'T'HH:mm:zz'Z'"
    }
}
