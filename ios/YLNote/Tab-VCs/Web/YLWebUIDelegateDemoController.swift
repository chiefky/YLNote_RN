//
//  YLWebUIDelegateDemoController.swift
//  YLNote
//
//  Created by tangh on 2023/7/1.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

class YLWebUIDelegateDemoController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    var webView: WKWebView = WKWebView()
    var button: UIButton = UIButton(type: .custom)
    var label:UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9794269204, green: 0.9398242831, blue: 0.8755992055, alpha: 1)

        // Initialize webView
        webView.navigationDelegate = self
        webView.uiDelegate = self
        self.view.addSubview(webView)
        
        // Add a button to trigger JavaScript function from Native (Objective-C)
        label.text = "2. native中调JS代码："
        label.font = UIFont.boldSystemFont(ofSize: 22)
        view.addSubview(label)

        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        button.setTitle("evaluateJavaScript执行JS方法,带返回值", for: .normal)
        button.layer.cornerRadius = 10;
        button.layer.masksToBounds = true;
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        
        guard let path = Bundle.main.path(forResource: "UIDelegateDemo", ofType: "html")  else { return }
        let url = URL(fileURLWithPath: path)
        let request = URLRequest(url: url)
        webView.load(request)

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
        
        webView.frame = CGRect(x: leftValue, y: topValue, width: layoutFrame.width, height: layoutFrame.height-topValue-85)
        label.frame = CGRect(x: leftValue, y: layoutFrame.height-85, width: layoutFrame.width, height: 20)
        button.frame = CGRect(x: leftValue+25, y: layoutFrame.height-55, width:  layoutFrame.width-50-leftValue, height: 45)

    }
    
    @objc func buttonAction() {
        
        self.webView.evaluateJavaScript("testObject('张三', '26岁')") { (res, error) in
            if let res = res {
                print("\(res), \(String(describing: error))")
            }
        }
    }
    
    
    // WKNavigationDelegate methods
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Handle webView finish navigation
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
    
    // WKUIDelegate methods
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确认", style: .default, handler: { (_) in
            completionHandler()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (_) in
            completionHandler(false)
        }))
        alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) in
            completionHandler(true)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: prompt, message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.text = defaultText
        }
        alertController.addAction(UIAlertAction(title: "完成", style: .default, handler: { (_) in
            completionHandler(alertController.textFields?.first?.text)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
