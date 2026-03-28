//
//  Color+ext.swift
//  FlowNest_Example
//
//  Created by Louis on 2026/3/28.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /// 16进制颜色
    /// - Parameters:
    ///  - hexString: 16进制颜色字符串
    ///  - alpha: 透明度
    /// - Returns: UIColor
    public static func color(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        var cString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            return UIColor.clear
        }
        
        let rString = String(cString.prefix(2))
        let gString = String(cString[cString.index(cString.startIndex, offsetBy: 2)..<cString.index(cString.startIndex, offsetBy: 4)])
        let bString = String(cString.suffix(2))
        var r: UInt64 = 0, g: UInt64 = 0, b: UInt64 = 0
        Scanner(string: rString).scanHexInt64(&r)
        Scanner(string: gString).scanHexInt64(&g)
        Scanner(string: bString).scanHexInt64(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
}

