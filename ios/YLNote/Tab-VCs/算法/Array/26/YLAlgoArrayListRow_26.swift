//
//  YLAlgoArrayListRow_26.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 57 - II. 和为s的连续正数序列

 输入一个正整数 target ，输出所有和为 target 的连续正整数序列（至少含有两个数）。
 序列内的数字由小到大排列，不同序列按照首个数字从小到大排列。

 示例 1：
 输入：target = 9
 输出：[[2,3,4],[4,5]]
 
 示例 2：
 输入：target = 15
 输出：[[1,2,3,4,5],[4,5,6],[7,8]]

 https://leetcode.cn/problems/he-wei-sde-lian-xu-zheng-shu-xu-lie-lcof/

 */
class YLAlgoArrayListRow_26: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @objc func testMethod_1() {
        let res = findContinuousSequence(9)
        print("🍎结果：\(res)")
    }
    
    /// 时间复杂度：O(n），空间复杂度：O(1）
    /// 滑动窗口
    func findContinuousSequence(_ target: Int) -> [[Int]] {
        guard target > 1 else {
            return [];
        }
        var res:[[Int]] = [];
        var sum = 0;
        var left = 1,right = 1;
        while left <= target/2 {
            if sum < target {
                sum += right;
                right += 1;
            } else if sum > target {
                sum -= left;
                left += 1;
            } else {
                var k = left;
                var arr:[Int] = [];
                while k < right {
                    arr.append(k);
                    k += 1;
                }
                res.append(arr);
                sum -= left;
                left += 1;
            }
        }
        return res;
    }
        
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_26"
    }
    
}
