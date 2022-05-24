//
//  YLAlgoStringViewControllerRow0.swift
//  YLNote
//
//  Created by tangh on 2022/3/7.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlgoStringViewControllerRow0: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func testReverse_recursive() {
        let str = "    hello world ! 90   "
        let reverse = res_reversWord(str)
        
        print("🐢\(reverse)😯")
        
    }
    @objc func testReverse_iteration() {
        let str = "the sky is blue"
        let reverse = reverseWords(str)
        
        print("🍎：\(reverse)")
        
    }

    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_0"
    }
}
