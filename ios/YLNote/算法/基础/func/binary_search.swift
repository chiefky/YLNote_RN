//
//  sort.swift
//  YLNote
//
//  Created by tangh on 2022/3/1.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation

///题目： 给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target  ，写一个函数搜索 nums 中的 target，如果目标值存在返回下标，否则返回 -1。

/// 迭代：二分查找
/// - Parameter target: 目标值
/// - Returns: index
func iterator_binary_search(_ nums: [Int], target: Int) -> Int {
    if nums.count <= 0 {
        return -1;
    }
    var left = 0
    var right = nums.count - 1;
    while left <= right {
        let mid = left + (right - left)/2;
        if nums[mid] < target { left = mid + 1 }
        if nums[mid] > target { right = mid - 1 }
        if nums[mid] == target { return mid }
    }
    return -1;
}

/// 递归：二分查找
/// - Parameters:
///   - nums: <#nums description#>
///   - target: <#target description#>
/// - Returns: <#description#>
func recursive_binary_search(_ nums: [Int], target: Int) -> Int {
    if nums.count <= 0 {
        return -1;
    }
    return recursiveLook(nums, target: target, low: 0, high: nums.count - 1 )
}


func recursiveLook(_ nums:[Int], target: Int,low: Int,high: Int) -> Int {
    guard low <= high else {
        return -1
    }
    let mid = low + (high - low)/2;
    if nums[mid] < target {
        return recursiveLook(nums, target: target, low: mid + 1, high: high)
        
    } else if nums[mid] > target {
        return recursiveLook(nums, target: target, low: low, high: mid - 1)
        
    } else {
        return mid
    }
}

