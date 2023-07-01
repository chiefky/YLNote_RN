//
//  YLWebMsgHandleDemoController.swift
//  YLNote
//
//  Created by tangh on 2023/6/30.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit
import WebKit

class YLWebMsgHandleDemoController: UIViewController {
    var wkWebView = WKWebView()
    var label:UILabel = UILabel()
    var butn = UIButton(type: .custom)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  #colorLiteral(red: 0.9794269204, green: 0.9398242831, blue: 0.8755992055, alpha: 1) // YLTheme.main().backColor
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var topValue:CGFloat = 0
        var leftValue:CGFloat = 0
        var layoutFrame = view.frame
        if #available(iOS 11.0, *) {
            layoutFrame = view.safeAreaLayoutGuide.layoutFrame
            let safeAreaInsets = view.safeAreaInsets
            topValue = safeAreaInsets.top
            leftValue = safeAreaInsets.left
        }
        
        wkWebView.frame = CGRect(x: leftValue, y: topValue, width: layoutFrame.width, height: layoutFrame.height-topValue-85)
        label.frame = CGRect(x: leftValue, y: layoutFrame.height-85, width: layoutFrame.width, height: 20)
        butn.frame = CGRect(x: leftValue+20, y: layoutFrame.height-55, width: layoutFrame.width-40, height: 45)
        
    }
    
    //MARK: functions
    func setupUI() {
        // 加载webview
        loadWebPage()
        
        // native 控件
        label.text = "2. native中调JS代码："
        label.font = UIFont.boldSystemFont(ofSize: 22)
        view.addSubview(label)
        
        butn.setTitle("evaluateJavaScript执行JS方法,不带返回值", for: .normal)
        butn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        butn.addTarget(self, action: #selector(nativeCallJS), for: .touchUpInside)
        butn.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        butn.layer.cornerRadius = 10;
        butn.layer.masksToBounds = true
        view.addSubview(butn)
        
    }
    
    func loadWebPage() {
        guard let url = Bundle.main.url(forResource: "MsgHandlerDemo", withExtension: "html") else { return }
        wkWebView.registerActions(self, func: ["sayHello","getUserInfo"])
        self.view.addSubview(wkWebView)
        let req = URLRequest(url: url)
        wkWebView.load(req)
    }
    
    @objc func nativeCallJS() {
        let userInfo = [
            "userID": "abc123",
            "msg":"用户信息：姓名：张三，年龄：19，总成绩：785分"]
        self.wkWebView.evaluateJavaScript("testObject('\(userInfo.jsonString)')") { (res, error) in
            if let res = res {
                print("\(res), \(String(describing: error))")
            }
        }
        
    }
    
    
}

extension YLWebMsgHandleDemoController: YLWKActionDelegate {
    
    /// 接收JS方法的统一入口
    /// - Parameters:
    ///   - name: 方法名
    ///   - arg: 参数
    func handleAllActions(func name: String, arg: Any) {
        switch name {
        case "sayHello":
            self.sayHello(param: arg)
        default:
            print("\(name) is undefined ,plese add an implementation!")
        }
    }
    
    func sayHello<T>(param: T )  {
        var message = "null"
        if let param = param as? String {
            message = param;
        } else if let obj = param as? [String:Any] {
            message = obj.jsonString
            // { "----- request userinfo with userID ------- "}
            let userInfo = [ "userID": obj["userID"] ?? "null",
                             "msg":"姓名：张三，年龄：19，总成绩：785分" ]
            if let function = obj["callBackFunc"] as? String {
                // 执行回调
                self.wkWebView.evaluateJavaScript("\(function)('\(userInfo.jsonString)')") { res, error in
                    if let res = res {
                        print(res)
                    }
                    if let error = error {
                        print(error)
                    }
                }
            }
            
        }
        print("Hello , \(message)!")
    }
        
}
