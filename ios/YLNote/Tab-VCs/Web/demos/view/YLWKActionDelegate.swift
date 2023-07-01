//
//  YLWKWebViewConfiguration.swift
//  YLNote
//
//  Created by tangh on 2023/6/30.
//  Copyright © 2023 tangh. All rights reserved.
//

import Foundation
import WebKit
import ObjectiveC.runtime


//class YLWKScriptMessageHandler: NSObject,WKScriptMessageHandler,YLWKActionDelegate {
//    func handleAllActions(func name: String, arg: Any) {
//
//    }
//
//    @objc func performAction(completion: () -> Void) {
//        // 执行一些操作
//        print("Performing action...")
//
//        // 调用闭包完成操作
//        completion()
//    }
//
//    // 在运行时动态添加方法的实现
//    func addMethod(name: String, method: Method) {
//        // 获取方法选择器
//        let selector = method_getName(method)
//        // 获取方法实现
//        let implementation = method_getImplementation(method)
//        // 获取方法的参数和返回类型编码
//        let typeEncoding = method_getTypeEncoding(method)
//        // 动态添加方法
//        let cls: AnyClass = YLWKScriptMessageHandler.self // 替换为你自己的类名
//        class_addMethod(cls, selector, implementation, typeEncoding)
//    }
//
//    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        print("响应到了：",userContentController,"message: ",message)
//    }
//
//    func registerMethod(_ name:String, closure:(@escaping ([String:String]) -> Void)) -> Bool{
//        // 举例：
//        // i    24    @    0    :    8    i    16    f    20
//        // int         id        SEL       int        float
//        // 参数的总占用空间为 8 + 8 + 4 + 4 = 24
//        // id 从第0位开始占据8位空间
//        // SEL 从第8位开始占据8位空间
//        // int 从第16位开始占据4位空间
//        // float 从第20位开始占据4位空间
//
//        // 动态添加一个方法
//        let myClosure: ([String:String]) -> Void = closure
//        let closureSelector = Selector(("customClosure:"))
//        let imp: IMP = imp_implementationWithBlock( { (obj: Any, str: NSString) in
//            print("jjjj哈哈哈：", str)
//        })
//
//        // 获取方法的参数和返回类型编码
//        let typeEncoding = "v@:@"//method_getTypeEncoding(method)
//        // 动态添加方法
//        let cls: AnyClass = YLWKScriptMessageHandler.self // 替换为你自己的类名
//        let sel_name = name + ":" + "argument:"
//        let res = class_addMethod(cls,Selector(sel_name),imp,typeEncoding);
//        return res
//    }
//
//}
//


/**
 使用方法：
 1. 使用WKWebView注册方法名，传入self作为函数的消息接收者；内部函数弱持有self
 wkWebView.registerAllActions(scriptMessageHandler: self, func: [method_name])
 2. 给self类遵循协议 YLWKActionDelegate，并实现’ func handleAllActions(func name:String,arg: Any)‘方法；此方法用于接收JS方的调用，根据name和arg分发函数完成native调用
 
 */

// iOS 14及更低版本
protocol YLWKActionDelegate: AnyObject {
    func handleAllActions(func name:String,arg: Any)
    
    @available(iOS 14.0, *)
    func handleAllActions(func name:String,arg: Any,replyHandler:  @escaping (Any?, String?) -> Void)
}

extension YLWKActionDelegate {

    func handleAllActions(func name:String,arg: Any,replyHandler:  @escaping (Any?, String?) -> Void) {
        handleAllActions(func: name, arg: arg)
    }
}


class YLWKMessageHandler: NSObject,WKScriptMessageHandler {
    deinit {
        print("YLWKMessageHandler deinit")
    }
    
    weak var delegate: YLWKActionDelegate?
    init(delegate: YLWKActionDelegate?) {
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
    
//    @available(iOS 14.0,*)
//    func registerActions(reply scriptMessageHandler: YLWKActionDelegate, func names: [String]) {
//        let target = YLWKMessageHandler(delegate: scriptMessageHandler)
//        for name in names {
////            [userContentController addScriptMessageHandlerWithReply:self contentWorld:[WKContentWorld pageWorld] name:@"YYWK"];
//            self.configuration.userContentController.addScriptMessageHandlerWithReply
//            self.configuration.userContentController.add(target, contentWorld: .page, name: name)
//        }
//    }

    /// 按脚本注册
    /// - Parameter script: <#script description#>
    func injectScript(_ script: String) {
        let script = WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        self.configuration.userContentController.addUserScript(script)
    }
    
}

