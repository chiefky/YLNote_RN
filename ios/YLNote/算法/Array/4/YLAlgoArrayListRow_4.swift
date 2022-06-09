//
//  YLAlgoArrayListRow_4.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。
 不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并 原地 修改输入数组。
 元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/remove-element
 */

class YLAlgoArrayListRow_4: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func testMethod_1() {
        var array = [0,0,1,1,1,2,2,3,3,4]
        let res = method_1(&array,3);
        print("结果：\(res)")
    }
    @objc func testMethod_2() {
        var array = [0,0,1,1,1,2,2,3,5,4]
        let res = method_2(&array,3);
        print("结果：\(res)")
    }
    
    /// 双指针：快慢指针
    /// - Parameter nums: <#nums description#>
    /// - Returns: <#description#>
    func method_1(_ nums: inout [Int],_ target: Int) -> Int {
        if nums.isEmpty {
            return 0;
        }
        var slow = 0;
        for fast in 0..<nums.count {
            if nums[fast] != target {
                nums[slow] = nums[fast];
                slow += 1;
            }
        }
        nums.removeSubrange(slow..<nums.count);
        return slow
    }
    
    /// 双指针: 左右指针
    /// 注意：right的临界问题，while循环必须能遍历到所有元素。
    /// - Parameter nums: <#nums description#>
    /// - Returns: <#description#>
    func method_2(_ nums: inout [Int],_ target:Int) -> Int {
        if nums.isEmpty {
            return 0;
        }
        var left = 0,right = nums.count;
        while left < right {
            if nums[left] == target {
                nums[left] = nums[right-1];
                right -= 1;
            } else {
                left += 1;
            }
        }
        nums.removeSubrange(left..<nums.count)
        return left
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_4"
    }
}
