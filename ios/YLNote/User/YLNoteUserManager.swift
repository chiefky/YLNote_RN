//
//  YLNoteUser.swift
//  YLNote
//
//  Created by tangh on 2021/3/25.
//  Copyright © 2021 tangh. All rights reserved.
//

import UIKit
import YYModel

class YLUserManager: NSObject {
    private static var defaultManager: YLUserManager = {
        let instance = YLUserManager()
        return instance
    }()
    
    @objc class func shared() -> YLUserManager {
        return defaultManager
    }
    
    //获取当前用户
    var currentUser: YLUser?
    var wallet: YLWallet?
    
    //是否已登录
    //true:登录，false:未登录
    @objc static func isLogin() -> Bool {
        if let sessionId = YLUserManager.shared().currentUser?.sessionID {
            if sessionId.count > 0 {
                return true
            }
        }
        return false
    }

}

//struct YLNoteUser {
//    var name: String
//    var gender: String
//    var age: UInt
//    var tel: String
//    var address: String
//    var avatarUrl: String?
//
//}


//class YLUser: NSObject {
//    var sessionID: String?
//
//    var name: String?
//    var gender: String?
//    var age: UInt?
//    var tel: String?
//    var address: String?
//    var avatarUrl: String?
//}
