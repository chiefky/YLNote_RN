//
//  merge_sort.swift
//  YLNote
//
//  Created by tangh on 2022/3/7.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation

func mergesort(_ nums:[Int]) -> [Int] {
    if nums.count <= 1 {
        return nums
    }
    
    let mid = (nums.count - 1)/2
    let l_num:[Int] = Array(nums[0...mid] )
    let r_num:[Int] = Array(nums[mid+1..<nums.endIndex])// Array(nums.suffix(mid))
    print("\(l_num);\(r_num)");
    
    var l_sort = mergesort(l_num)
    var r_sort = mergesort(r_num)
    let nums_sort = merge(&l_sort,&r_sort)
    return nums_sort
    
}

/// 两个有序数组合并为一个有序数组
/// - Parameters:
///   - num1: 如【1，2，9】
///   - num2: 如【3，5，8】
/// - Returns: 【1，2，3，5，8，9】
func merge(_ num1: inout [Int], _ num2: inout [Int]) -> [Int] {
    
    guard num1.count > 0 ,num2.count > 0 else {
        return num1.isEmpty ? num2 : num1
    }

    var nums = [Int]()
    while num1.count > 0,  num2.count > 0 {
        if let m = num1.first, let n = num2.first {
            if m <= n {
                nums.append(m)
                num1.removeFirst()
            } else {
                nums.append(n)
                num2.removeFirst()
            }
        }
    }
    
    if num1.count > 0 {
        nums += num1
    }
    
    if num2.count > 0 {
        nums += num2
    }
    return nums
}
