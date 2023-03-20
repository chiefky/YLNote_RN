//
//  YLAlgoArrayListRow_14.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给你一个数组，将数组中的元素向右轮转 k 个位置，其中 k 是非负数。

 示例 1:
 输入: nums = [1,2,3,4,5,6,7], k = 3
 输出: [5,6,7,1,2,3,4]
 解释:
 向右轮转 1 步: [7,1,2,3,4,5,6]
 向右轮转 2 步: [6,7,1,2,3,4,5]
 向右轮转 3 步: [5,6,7,1,2,3,4]

 链接：https://leetcode.cn/problems/rotate-array
 
 */

class YLAlgoArrayListRow_14: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        var array = [1,2,3,4,5,6,7]
         method_1(&array,3);
        print("🍎结果：\(array)")
    }
    
    @objc func testMethod_2() {
        var array = [1,2,3,4,5,6,7]
         rotate(&array,3);
        print("🍎结果：\(array)")
    }
    
    /// 时间复杂度:O(3logn),空间复杂度：O(1)
    /// 左右翻转
    func rotate(_ nums: inout [Int], _ k: Int) {
        let k = k%nums.count;
        reverse(&nums, 0, nums.count-1)
        reverse(&nums, 0, k-1)
        reverse(&nums, k, nums.count-1)
    }
    
    
    /// 时间复杂度：O(n)，空间复杂度:O(1)
    /// 双指针
    func reverse(_ nums: inout [Int], _ start:Int,_ end:Int) {
        guard start <= end,start >= 0,end <= nums.count-1 else { return };
        var left = start, right = end;
        while left < right {
            nums.swapAt(left, right);
            left += 1;
            right -= 1;
        }
    }
    
    /// 新建数组，时间复杂度：O(n),空间复杂度：O(n）
    /// - Parameters:
    ///   - nums: [1,2,3,4,5,6,7]
    ///   - k: 3
    func method_1(_ nums: inout [Int],_ k:Int) {
        guard !nums.isEmpty else {
            return
        }
        
        let length = nums.count
        var res:[Int] = Array(repeating: 0, count: length)
        
        let first = nums[0]
        var idx = length-1
        while idx >= 0 {
            let loc = (idx+k)%length
            let tmp = nums[idx]
            res[loc] = idx == 0 ? first : tmp
            idx -= 1
        }
        nums = res
    }
    
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_14"
    }
  
}
