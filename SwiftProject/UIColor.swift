//
//  UIColor.swift
//  XCTG3
//
//  Created by LTHJ on 2017/1/12.
//  Copyright © 2017年 lthj. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Hex转换成UIColor
extension UIColor{
    class func colorWithHexString(hex:String) -> UIColor {
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            let index = cString.index(cString.startIndex, offsetBy: 1)
            cString = cString.substring(from: index)
        }
        
        if cString.characters.count != 6 {
            return UIColor.red
        }
        
        let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = cString.substring(to: rIndex)
        let otherString = cString.substring(from: rIndex)
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        let gString = otherString.substring(to: gIndex)
        let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        let bString = cString.substring(from: bIndex)
        
        var r:CUnsignedInt = 0
        var g:CUnsignedInt = 0
        var b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    
   /// 视图背景色
   ///
   /// - Returns: 指定的颜色值
   class func HJColorBack() -> UIColor {
        return UIColor.colorWithHexString(hex: "#efeff4")
    }
}
