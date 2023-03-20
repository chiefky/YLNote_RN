//
//  UIColorTools.swift
//  YLNote
//
//  Created by tangh on 2021/2/22.
//  Copyright © 2021 tangh. All rights reserved.
//

import Foundation
//MARK: base
extension UIColor {
    //    func color(hex:String) -> UIColor {
    //        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    //
    //        if (cString.hasPrefix("#")) {
    //            cString.remove(at: cString.startIndex)
    //        }
    //
    //        if ((cString.count) != 6) {
    //            return UIColor.gray
    //        }
    //
    //        var rgbValue:UInt64 = 0
    //        Scanner(string: cString).scanHexInt64(&rgbValue)
    //
    //        return UIColor(
    //            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
    //            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
    //            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
    //            alpha: CGFloat(1.0)
    //        )
    //    }
    
    //🌰： “#FAF0DF”
    @objc convenience init(hex: String,alpha:CGFloat = 1.0) {
        // 存储转换后的数值
        var red: UInt64 = 0, green: UInt64 = 0, blue: UInt64 = 0
        var hex = hex
        
        // 如果传入的十六进制颜色有前缀，去掉前缀
        if hex.hasPrefix("0x") || hex.hasPrefix("0X") {
            hex = String(hex[hex.index(hex.startIndex, offsetBy: 2)...])
        } else if hex.hasPrefix("#") {
            hex = String(hex[hex.index(hex.startIndex, offsetBy: 1)...])
        }
        
        // 如果传入的字符数量不足6位按照后边都为0处理，当然你也可以进行其它操作
        if hex.count < 6 {
            for _ in 0..<6-hex.count {
                hex += "0"
            }
        }
        
        // 分别进行转换
        // 红
        Scanner(string: String(hex[..<hex.index(hex.startIndex, offsetBy: 2)])).scanHexInt64(&red)
        // 绿
        Scanner(string: String(hex[hex.index(hex.startIndex, offsetBy: 2)..<hex.index(hex.startIndex, offsetBy: 4)])).scanHexInt64(&green)
        // 蓝
        Scanner(string: String(hex[hex.index(hex.startIndex, offsetBy: 4)...])).scanHexInt64(&blue)
                
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    }
    
    
    /// 随机色值
    @objc static func random() -> UIColor {
        return UIColor(red: .random(),
                       green: .random(),
                       blue: .random(),
                       alpha: 1.0)
    }
}

//MARK: Skin
extension UIColor {
    func skinColor(name: String) -> UIColor {
        let dict = YLSkinMananger.defaultManager().skinMap
        guard let key = dict["selectColor"] as? String,let dic = dict[key] as? NSDictionary,let colorHex = dic["color"] as? String else { return .clear }
        return UIColor(hex: colorHex)
    }
}
