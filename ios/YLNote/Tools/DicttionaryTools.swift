//
//  DicttionaryTools.swift
//  YLNote
//
//  Created by tangh on 2023/7/1.
//  Copyright © 2023 tangh. All rights reserved.
//

import Foundation
extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    
    var jsonString:String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            if let string = String(data: jsonData, encoding: String.Encoding.utf8){
                return string
            }
        } catch {
            print("JSONSerialization is falied. Error: \(error)")
        }
        return ""
    }
}
