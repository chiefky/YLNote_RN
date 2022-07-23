//
//  YLAlgoArrayListRow_0_2.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/*
 给定一个包含 n + 1 个整数的数组 nums ，其数字都在 [1, n] 范围内（包括 1 和 n），可知至少存在一个重复的整数。
 假设 nums 只有 一个重复的整数 ，返回 这个重复的数 。
 你设计的解决方案必须 不修改 数组 nums 且只用常量级 O(1) 的额外空间。

 链接：https://leetcode.cn/problems/find-the-duplicate-number
 */
class YLAlgoArrayListRow_0_2: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_2() {
        let array = [2,3,1,4,2,5,3] // [2,3,1,0,2,5,3]
        let res = method_binarysearch(array);
        print("重复元素是：\(res)")
    }

    @objc func testMethod_1() {
        var array = [2,3,1,4,2,5,3] // [2,3,1,0,2,5,3]
        let res = method_swap(&array);
        print("重复元素是：\(res)")
    }

    /// 方法一: 原地交换 【时间复杂度：O(n); 空间复杂度：O(1)】
    /// 原地交换的使用前提是数组中的元素不能超过n
    /// - Parameter nums: 数组
    /// - Returns: 重复元素
    func method_swap(_ nums: inout [Int]) -> Int {
        var i = 0
        while i < nums.count {
            if i == nums[i] {
                i += 1
                continue;
            }
            if nums[i] == nums[nums[i]] {
                return nums[i]
            }
            print("🌹：\(nums)")
            nums.swapAt(i, nums[i])
            print("🌸：\(nums)")
        }
        return -1
    }
        
    /// 方法二：二分查找 【时间复杂度：O(nlogn); 空间复杂度：O(1)】
    /// - Parameter nums: 数组
    /// - Returns: 重复元素
    func method_binarysearch(_ nums:[Int]) -> Int {
        var left = 1, right = nums.count - 1 // 初始right值实际是n
        while left < right {
            let mid = left + (right-left)/2
            print("数字区间：[\(left)...\(right)]， 中位数：\(mid)")
            var count = 0
            for num in nums {
                if num <= mid {
                    count += 1
                }
            }
            print("原始数组中 ≤\(mid) 的个数：\(count)")
            if count > mid {
                right = mid
            } else {
                left = mid + 1
            }
            print("🧒中位数: \(mid),≤\(mid)的个数:\(count),新区间：[\(left)...\(right)]")
        }
        return left
    }

    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_0_2"
    }
}
