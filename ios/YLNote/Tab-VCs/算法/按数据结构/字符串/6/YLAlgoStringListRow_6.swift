//
//  YLAlgoStringListRow_6.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 反转字符串
 
 编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 s 的形式给出。
 不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。
  
链接：https://leetcode.cn/problems/reverse-string
 */
class YLAlgoStringListRow_6: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod() {
        let str = "Let's take LeetCode contest"
        var res = Array(str)
        method_1(&res)
        print("🍎1：\(res)")

    }
    
    func method_1(_ s: inout [Character]) {
        var left = 0,right = s.count-1
        while left < right {
            s.swapAt(left, right)
            left += 1;
            right -= 1;
        }
    }


    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_6"
    }
}
