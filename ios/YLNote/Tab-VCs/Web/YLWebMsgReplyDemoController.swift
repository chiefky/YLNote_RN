//
//  YLWebMsgReplyDemoController.swift
//  YLNote
//
//  Created by tangh on 2023/7/2.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit
import WebKit

class YLWebMsgReplyDemoController: UIViewController {
    var webView : WKWebView?
    let JavaScriptAPIObjectName = "namespaceWithinTheInjectedJSCode"
    var label:UILabel = UILabel()
    var butn = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  #colorLiteral(red: 0.9794269204, green: 0.9398242831, blue: 0.8755992055, alpha: 1) // YLTheme.main().backColor
        loadWebPage()
    }
    
    deinit {
           if let webView = webView{
               let ucc = webView.configuration.userContentController
               ucc.removeAllUserScripts()
               ucc.removeScriptMessageHandler(forName:JavaScriptAPIObjectName)
           }
       }

    //MARK: functions
    func loadWebPage() {
        guard let htmlPath = Bundle.main.url(forResource: "MsgReplyDemo", withExtension: "html") else {
            return;
        }
        
//        let config = WKWebViewConfiguration()
//        let userContentController = WKUserContentController()
        // REQUIRES IOS14
//        if #available(iOS 14, *){
//            let target = YLWKMessageReplyHandler()
//            userContentController.addScriptMessageHandler(target, contentWorld: .page, name: JavaScriptAPIObjectName)
//            userContentController.addScriptMessageHandler(target, contentWorld: .page, name: "requestData")
//        }
//        config.userContentController = userContentController
        
        webView = WKWebView() //WKWebView(frame: .zero, configuration: config)
       if let webView = webView{
           if #available(iOS 14, *){
               webView.registerActions(reply: self, func: [JavaScriptAPIObjectName,"requestData"])
           }
           view.addSubview(webView)
           webView.snp.makeConstraints {
               $0.edges.equalToSuperview();
           };
           let req = URLRequest(url: htmlPath)
           webView.load(req)

       }

    }
    
}
extension YLWebMsgReplyDemoController: YLWKActionDelegate14Plus {
    
    func handleAllActions(func name: String, arg: Any, replyHandler: @escaping (Any?, String?) -> Void) {
            switch name {
            case JavaScriptAPIObjectName:
                replyHandler( 2.2, nil )
            case "requestData":
                replyHandler( 2.2, nil )

            default:
                print("undefined!")
            }
    }
}

