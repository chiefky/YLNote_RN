//
//  Page.swift
//  YLNote
//
//  Created by tangh on 2023/6/28.
//  Copyright © 2023 tangh. All rights reserved.
//

import Foundation

struct Page: Codable {
    var id: String?
    var name: String?
    var param: [String: String]?
    
    enum CodingKeys: String, CodingKey {
        case id = "pageId"
        case name = "pageName"
        case param = "pageParam"
    }
}


struct ItemData {
    var title:String
    var oriData: Any
}
