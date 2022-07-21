//
//  YLAlgoArrayListRow_21.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 21. 调整数组顺序使奇数位于偶数前面
 输入一个整数数组，实现一个函数来调整该数组中数字的顺序，使得所有奇数在数组的前半部分，所有偶数在数组的后半部分。

 示例：
 输入：nums = [1,2,3,4]
 输出：[1,3,2,4]
 注：[3,1,2,4] 也是正确的答案之一。
 
 https://leetcode.cn/problems/diao-zheng-shu-zu-shun-xu-shi-qi-shu-wei-yu-ou-shu-qian-mian-lcof/
 */
class YLAlgoArrayListRow_21: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let arr = [1,2,3,4,5]
        let res = exchange(arr)
        print("🍎结果：\(res)")
    }
    
    /// 时间复杂度 O(n）
    /// 空间复杂度O(1)
    /// - Parameter nums: 原始数组
    /// - Returns: 先奇后偶 数组
    func exchange(_ nums: [Int]) -> [Int] {
        guard nums.count > 1 else {
            return nums
        }
        var res = nums
        var l = 0,r = res.count-1
        while l < r {
            // 从右->左 找第一个奇数的下标
            while r > l, res[r] % 2 == 0 {
                r -= 1
            }
            // 从左->右 找第一个偶数的下标
            while l < r, res[l] % 2 == 1 {
                l = l + 1
            }
            if l < r {
                res.swapAt(l, r)
                print("🌹(\(l),\(r))交换位置：\(res)")
            }
            l += 1
            r -= 1
        }
        return res
    }
    
   

    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_21"
    }
    
}
