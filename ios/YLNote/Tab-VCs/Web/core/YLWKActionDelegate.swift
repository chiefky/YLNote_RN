//
//  YLWKWebViewConfiguration.swift
//  YLNote
//
//  Created by tangh on 2023/6/30.
//  Copyright © 2023 tangh. All rights reserved.
//

import Foundation
import WebKit


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

// iOS 14以下
protocol YLWKActionDelegate:AnyObject {
    func handleAllActions(func name:String,arg: Any)
}

extension YLWKActionDelegate {
    func handleAllActions(func name: String, arg: Any) {
        
    }
}

// iOS 14及更高版本
@available(iOS 14.0, *)
protocol YLWKActionDelegate14Plus:YLWKActionDelegate {
    func handleAllActions(func name:String,arg: Any,replyHandler:  @escaping (Any?, String?) -> Void)
}


