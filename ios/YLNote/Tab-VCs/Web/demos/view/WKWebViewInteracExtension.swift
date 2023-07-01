//
//  WKWebViewInteracExtension.swift
//  YLNote
//
//  Created by tangh on 2023/7/2.
//  Copyright © 2023 tangh. All rights reserved.
//

import Foundation

// 为WKWebView添加方法：注册响应事件
extension WKWebView {
    
    /// 按方法名注册
    /// - Parameters:
    ///   - scriptMessageHandler: action响应者
    ///   - names: 方法名数组
    func registerActions(_ scriptMessageHandler: YLWKActionDelegate, func names: [String]) {
        let target = YLWKMessageHandler(delegate: scriptMessageHandler)
        for name in names {
            self.configuration.userContentController.add(target, name: name)
        }
    }

    @available(iOS 14,*)
    func registerActions(reply scriptMessageHandler: YLWKActionDelegate14Plus, func names: [String]) {
        let target = YLWKMessageReplyHandler(delegate: scriptMessageHandler)
        for name in names {
            self.configuration.userContentController.addScriptMessageHandler(target, contentWorld: .page, name: name)
        }
    }
    
}
