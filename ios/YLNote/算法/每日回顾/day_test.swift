//
//  day_test.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation

/// 二分查找
/// - Parameters:
///   - nums: [-1,0,3,5,9,12] 必须是有序数组
///   - target: 3
/// - Returns: 2
func day_test_binary_search(_ nums:[Int], target: Int) -> Int {
    if nums.count <= 0 {
        return -1
    }
    
    var low = 0
    var high = nums.count - 1
    while low <= high {
        let mid = low + (high - low) / 2
        if target == nums[mid]{
            return mid
        } else if target < nums[mid] {
            high = mid - 1
        } else {
            low = mid + 1
        }
    }
    return -1
}

func day_test_binary_search_res(_ nums:[Int], target: Int, low: Int,high: Int) -> Int {
    
    guard low <= high else {
        return -1
    }
    
    var res = -1
    
    let mid = low + (high - low) / 2
    if target == nums[mid]{
        return mid
    }
    if target < nums[mid] {
       res = day_test_binary_search_res(nums, target: target, low: low, high: mid - 1)
    }
    if target > nums[mid] {
       res = day_test_binary_search_res(nums, target: target, low: mid + 1, high: high)
    }
    return res
}

/// 快速排序
/// - Parameters:
///   - nums: 【1，2，9，3，5，8】
///   - low: 0
///   - high: count-1
/// - Returns: 【1，2，3，5，8，9】
func day_test_quicksort(_ nums:inout [Int],low: Int, high: Int) -> [Int] {
    guard low < high else {
        return nums
    }
    var l = low
    var h = high
    
    while l < h {
        while l < h , nums[h] >= nums[low] {
            h -= 1
        }
        while l < h, nums[l] <= nums[low] {
            l += 1
        }
        nums.swapAt(l, h)
    }
    nums.swapAt(low, l)
    
    let _ = day_test_quicksort(&nums, low: l + 1, high: high)
    let _ = day_test_quicksort(&nums, low: low, high: l - 1)

    return nums;
}


/// 归并排序
/// - Parameter nums: 【1，2，9，3，5，8】
/// - Returns: 【1，2，3，5，8，9】
func day_test_mergesort(_ nums:[Int]) -> [Int] {
    if nums.count < 2 {
        return nums
    }
    
    let mid = (nums.count - 1)/2
    let num_l:[Int] = Array(nums[0...mid])
    let num_r:[Int] = Array(nums[mid+1 ..< nums.endIndex])
    var num_l_sort = day_test_mergesort(num_l)
    var num_r_sort = day_test_mergesort(num_r)
    let res = day_test_merge(&num_l_sort, &num_r_sort)
    return res;
}

/// 两个有序数组合并为一个有序数组
/// - Parameters:
///   - num1: 如【1，2，9】
///   - num2: 如【3，5，8】
/// - Returns: 【1，2，3，5，8，9】
fileprivate func day_test_merge(_ num1: inout [Int], _ num2: inout [Int]) -> [Int] {
    guard num1.count > 0 ,num2.count > 0 else {
        return !num1.isEmpty ? num1 : num2
    }
    
    var nums = [Int]()
    while !num1.isEmpty && !num2.isEmpty {
        if let n1 = num1.first,let n2 = num2.first {
            if n1 <= n2 {
                nums.append(n1)
                num1.removeFirst()
            } else {
                nums.append(n2)
                num2.removeFirst()
            }
        }
    }
    
    if !num1.isEmpty {
        nums += num1
    }
    
    if !num2.isEmpty {
        nums += num2
    }
    return nums
}
