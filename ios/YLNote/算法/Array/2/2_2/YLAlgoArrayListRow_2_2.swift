//
//  YLAlgoArrayListRow_2.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给你一个下标从 1 开始的整数数组 numbers ，该数组已按 非递减顺序排列  ，请你从数组中找出满足相加之和等于目标数 target 的两个数。如果设这两个数分别是 numbers[index1] 和 numbers[index2] ，则 1 <= index1 < index2 <= numbers.length 。
 以长度为 2 的整数数组 [index1, index2] 的形式返回这两个整数的下标 index1 和 index2。
 你可以假设每个输入 只对应唯一的答案 ，而且你 不可以 重复使用相同的元素。
 你所设计的解决方案必须只使用常量级的额外空间。
  
 示例 1：
 输入：numbers = [2,7,11,15], target = 9
 输出：[1,2]
 解释：2 与 7 之和等于目标数 9 。因此 index1 = 1, index2 = 2 。返回 [1, 2]
 
 链接：https://leetcode.cn/problems/two-sum-ii-input-array-is-sorted
 */

class YLAlgoArrayListRow_2_2: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func testMethod1() {
        let array = [2,3,4]
        let res = method_1(array, 6);
        print("结果：\(res)")
    }
    
    
    @objc func testMethod2() {
        let array = [1,3,4,11,12,13]
        let res = method_2(array, 17);
        print("结果：\(res)")
    }

    /// 时间复杂度: O(nlogn)，空间复杂度：O(1)
    /// 二分查找
    func method_1(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.count <= 1 {
            return []
        }
        for i in 0..<nums.count {
            var low = i,high = nums.count-1
            while low <= high {
                let another = target - nums[i]
                let mid = low + (high - low)/2
                print("🌸\(i):[\(low)-\(high)],\(mid)")
                if another == nums[mid] {
                    return [i+1,mid+1];
                } else if another < nums[mid] {
                    high = mid-1;
                } else {
                    low = mid+1
                }
            }
        }
        
        return [];
    }
    
    func method_2(_ numbers: [Int], _ target: Int) -> [Int] {
        guard numbers.count > 1 else {
            return [];
        }
        var left = 0,right = numbers.count-1
        while left < right {
            let sum = numbers[left] + numbers[right]
            if target == sum {
                return [left+1,right+1]
            } else if target > sum {
                left += 1
            } else {
                right -= 1
            }
        }
        return []
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_2_2"
    }
}
