//
//  YLWKMessageReplyHandler.swift
//  YLNote
//
//  Created by tangh on 2023/7/2.
//  Copyright © 2023 tangh. All rights reserved.
//

import Foundation
let JavaScriptAPIObjectName = "namespaceWithinTheInjectedJSCode"

@available(iOS 14.0,*)
class YLWKMessageReplyHandler: NSObject,WKScriptMessageHandlerWithReply {
    weak var delegate:YLWKActionDelegate14Plus?
    init(delegate: YLWKActionDelegate14Plus? = nil) {
        self.delegate = delegate
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage, replyHandler: @escaping (Any?, String?) -> Void) {
        print("hold 住啦啦啦啦啦")
        guard let delegate = delegate else {
            return replyHandler(nil,"YLWKMessageReplyHandler.delegate is nil,can not hold any message")}
        delegate.handleAllActions(func: message.name, arg: message.body, replyHandler: replyHandler)
    }
    
}
