//
//  YLWKMessageHandler.swift
//  YLNote
//
//  Created by tangh on 2023/7/2.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit

class YLWKMessageHandler: NSObject,WKScriptMessageHandler {
    deinit {
        print("YLWKMessageHandler deinit")
    }
    
    weak var delegate:YLWKActionDelegate?
    init(delegate: YLWKActionDelegate? = nil) {
        self.delegate = delegate
    }
        
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let delegate = self.delegate else {
            print("delegate is nil,can not hold any message!")
            return
        }
        delegate.handleAllActions(func: message.name, arg: message.body)
    }
    
}

