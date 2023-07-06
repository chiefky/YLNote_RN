//
//  YLAlgoArrayListRow_12_2.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给你一个整数数组 nums ，除某个元素仅出现 一次 外，其余每个元素都恰出现 三次 。请你找出并返回那个只出现了一次的元素。

 示例 1：
 输入：nums = [2,2,3,2]
 输出：3

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/single-number-ii
 */

class YLAlgoArrayListRow_12_2: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        
        let arr = [-2,-2,1,1,4,1,4,4,-4,-2];
        let res = singleNumber(arr)
        print("结果：\(res)")
    }
    
    /// 时间复杂度：O(64n)，空间复杂度：O(1)
    /// 按位运算
    func singleNumber(_ nums: [Int]) -> Int {
        var res = 0;
        var i = 0
        while i < 64 {
            var sum_i = 0
            for num in nums {
                let tmp = num>>i
                let x = tmp & 1
                sum_i += x
            }
            if sum_i%3 == 1 {
                res |= (1<<i)
            }
            i += 1;
        }
        return res;
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_12_2"
    }

}
