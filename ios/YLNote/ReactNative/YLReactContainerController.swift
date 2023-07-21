//
//  YLReactContainerController.swift
//  YLNote
//
//  Created by tangh on 2023/6/28.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit
import React
import CodePush
class YLReactContainerController: UIViewController {


    var moduleName:String = "" {
        didSet {
            guard !moduleName.isEmpty, moduleName != oldValue else { return }
            preloadUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    func preloadUI() {
        self.title = moduleName
        #if DEBUG
            guard let jsCodeLocation = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackExtension: nil) else { return }
        #else
        guard let jsCodeLocation = CodePush.bundleURL() else {return}
        #endif
            let rootView = RCTRootView(bundleURL: jsCodeLocation, moduleName: moduleName, initialProperties: nil)
            self.view = rootView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
