//
//  UIColor.hex.swift
//  GithubKit
//
//  Created by Takashi Kinjo on 27/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import Foundation

extension UIColor {
    convenience init?(hexString: String) {
        let hexString = hexString.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexString).apply {
            $0.scanLocation = 0
        }
        var color: UInt64 = 0
        if scanner.scanHexInt64(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >>  8) / 255.0
            let b = CGFloat((color & 0x0000FF) >>  0) / 255.0
            self.init(red: r, green: g, blue: b, alpha: 1.0)
            return
        }
        return nil
    }
}
