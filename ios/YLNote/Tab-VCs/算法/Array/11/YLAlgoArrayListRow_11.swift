//
//  YLAlgoArrayListRow_11.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 169. 多数元素
 给定一个大小为 n 的数组 nums ，返回其中的多数元素。多数元素是指在数组中出现次数 大于 ⌊ n/2 ⌋ 的元素。
 你可以假设数组是非空的，并且给定的数组总是存在多数元素。

 链接：https://leetcode.cn/problems/majority-element/description/
*/

class YLAlgoArrayListRow_11: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let nums = [2,2,1,1,1,2,2]//"A man, a plan, a anal: Panama";
        let res = majorityElement(nums)
        print("结果：\(res)")
    }
    
    /// 时间复杂度：O(n)，空间复杂度：O(1)
    /// 投票选举
    func majorityElement(_ nums: [Int]) -> Int {
        var res = 0,vote = 0;
        for num in nums {
            if vote == 0 {
                res = num;
            }
            vote += (num==res) ? 1 : -1
        }
        return res;
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_11"
    }

}
