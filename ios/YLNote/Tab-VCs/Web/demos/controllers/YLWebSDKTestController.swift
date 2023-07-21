//
//  YLWebSDKTestController.swift
//  YLNote
//
//  Created by tangh on 2023/7/21.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit

class YLWebSDKTestController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: lazy
    var scrollView:UIScrollView = {
        let v = UIScrollView(frame: .zero)
        return v
    }()

}
