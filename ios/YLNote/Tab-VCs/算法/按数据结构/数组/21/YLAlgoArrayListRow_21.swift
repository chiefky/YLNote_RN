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
    
    /// 时间复杂度 O(n）, 空间复杂度O(1)
    /// 左右指针
    func exchange(_ nums: [Int]) -> [Int] {
        var res = nums;
        var left = 0 ,right = nums.count-1;
        while left < right {
            while left<right, nums[left]&1 == 1 {
                left += 1;
            }
            while left<right, nums[right]&1 == 0 {
                right -= 1;
            }
            res.swapAt(left, right)
            left += 1;
            right -= 1;
        }
        return res;
    }

    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_21"
    }
    
}
