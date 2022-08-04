//
//  YLAlgoArrayListRow_25.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 53 - I. 在排序数组中查找数字 I
 统计一个数字在排序数组中出现的次数。

 示例 1:
 输入: nums = [5,7,7,8,8,10], target = 8
 输出: 2
 
 示例 2:
 输入: nums = [5,7,7,8,8,10], target = 6
 输出: 0
  

 提示：
 0 <= nums.length <= 105
 -109 <= nums[i] <= 109
 nums 是一个非递减数组
 -109 <= target <= 109
  

 https://leetcode.cn/problems/zai-pai-xu-shu-zu-zhong-cha-zhao-shu-zi-lcof/
 */
class YLAlgoArrayListRow_25: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @objc func testMethod_1() {
        let arr = [5,7,7,8,8,10]
        let res = search(arr, 8)
        print("🍎结果：\(res)")
    }

    @objc func testMethod_2() {
        let arr = [5,7,7,8,8,10]
        let res = binary_search(arr, 8)
        print("🍎结果：\(res)")
    }

    
    func search(_ nums: [Int], _ target: Int) -> Int {
        var count = 0
        var left = 0, right = nums.count - 1
        while left <= right {
            let mid = left + (right-left)/2
            if target == nums[mid] {
                left = mid;
                right = mid+1;
                while left >= 0 {
                    if target == nums[left] {
                        count += 1
                    } else {
                        break;
                    }
                    left -= 1;
                }
                
                while right <= nums.count - 1 {
                    if target == nums[right] {
                        count += 1;
                    } else {
                        break;
                    }
                    right += 1;
                }
                
                break;
            } else if target < nums[mid]  {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        
        return count
    }
    
    func binary_search(_ nums: [Int], _ target: Int) -> Int {
        let right = find_location(nums, target)
        let left = find_location(nums, target-1)
        return right - left
    }
    
    /// 查找元素的最右侧插入点
    /// - Parameters:
    ///   - nums: nums
    ///   - target: 目标元素
    /// - Returns: 最右侧插入点的位置
    func find_location(_ nums: [Int],_ target: Int) -> Int {
        var left = 0,right = nums.count - 1
        while left <= right {
            let mid = left + (right-left)/2
            if target < nums[mid] {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        return left
    }
    
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_25"
    }
    
}
