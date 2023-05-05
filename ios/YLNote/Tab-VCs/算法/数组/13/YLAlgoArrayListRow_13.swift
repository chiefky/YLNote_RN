//
//  YLAlgoArrayListRow_13.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。

 示例 1：
 输入：nums = [-4,-1,0,3,10]
 输出：[0,1,9,16,100]
 解释：平方后，数组变为 [16,1,0,9,100]
 排序后，数组变为 [0,1,9,16,100]

 示例 2：
 输入：nums = [-7,-3,2,3,11]
 输出：[4,9,9,49,121]
 
 链接：https://leetcode.cn/problems/squares-of-a-sorted-array
 */

class YLAlgoArrayListRow_13: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let array = [-4,-1,0,3,10]
        let res = sortedSquares(array);
        print("🍎结果：\(res)")
    }
    
    @objc func testMethod_2() {
        let array = [-7,-3,2,3,11]
        let res = method_2(array);
        print("🍎结果：\(res)")
    }
    
    /// 时间复杂度：O(n），空间复杂度：O(1)
    /// 双指针逆向插入
    func sortedSquares(_ nums: [Int]) -> [Int] {
        var left = 0,right = nums.count-1;
        var res:[Int] = Array(repeating: 0, count: nums.count)
        var qos = right;
        while left <= right {
            if abs(nums[left]) > abs(nums[right]) {
                res[qos] = (nums[left]*nums[left]);
                left += 1;
            } else {
                res[qos] = (nums[right]*nums[right]);
                right -= 1;
            }
            qos -= 1
        }
        return res
    }
    
 
    
    func method_2(_ nums:[Int]) -> [Int] {
        guard !nums.isEmpty else {
            return nums
        }
        
        let res = nums.map { $0*$0 }.sorted()
        return res
    }
    
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_13"
    }
  
}
