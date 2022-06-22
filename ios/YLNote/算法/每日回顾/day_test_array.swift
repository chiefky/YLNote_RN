//
//  day_test_array.swift
//  YLNote
//
//  Created by tangh on 2022/6/19.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation

func testArray()  {
    var nums:[Int] = [0,0,1,1,1,1,9,2,3,3,4]//[0,0,1,1,1,2,2,3,3,4]
    let res = array_method_qes_4(&nums,1)
    print("👨‍👩‍👧‍👦结果：\(res)")
    
}

///  寻找重复数
/// - Parameter nums: [1,3,4,2,2]
/// - Returns: 2
func array_method_qes_0(_ nums:[Int]) -> Int {
    var left = 1, right = nums.count - 1 // 初始right值实际是n
    print("🧒中位数: \(left + (right-left)/2),初始区间：[\(left)...\(right)]")
    while left < right {
        let mid = left + (right-left)/2
        var count = 0
        for num in nums {
            if num <= mid {
                count += 1
            }
        }
        if count > mid {
            right = mid
        } else {
            left = mid + 1
        }
        print("🧒中位数: \(mid),≤\(mid)的个数:\(count),新区间：[\(left)...\(right)]")
    }
    return left
}

/// 判断一个数组是否是连续的
/// - Parameter nums: [1,2,3,5]
/// - Returns: false
func array_method_qes_1(_ nums:[Int]) -> Bool {
    guard nums.count > 1 else {
        return false
    }
    let sorted = nums.sorted()
    for i in 1...sorted.count-1 {
        let distance = sorted[i] - sorted[i-1]
        if abs(distance) != 1 {
            return false
        }
    }
    return true
}

/// . 两数之和
/// - Parameters:
///   - nums: nums = [2,7,11,15]
///   - target: 9
/// - Returns: [0,1]
func array_method_qes_2(_ nums:[Int],target:Int) -> [Int] {
    for (idx,num) in nums.enumerated() {
       if nums.contains(target-num) {
           let idx2 = nums.firstIndex(of: target-num)!
           if idx2 != idx {
               return [idx,idx2]
           }
       }
   }
   return []
}

///  删除有序数组中的重复项
/// - Parameter nums: [0,0,1,1,1,2,2,3,3,4]
/// - Returns: 5, nums = [0,1,2,3,4]
func array_method_qes_3(_ nums: inout [Int]) -> Int {
    var last = 0
    print("▶️\(nums)")
    for i in 0..<nums.count {
        if nums[i] != nums[last] {
            last += 1 // 第N次出错：先+1,后赋值
            nums[last] = nums[i]
        }
        print("🌸\(nums):\(last)");
    }
    
    if nums.endIndex > last+1 {
        nums.removeSubrange(last+1..<nums.endIndex)
    }
    print("⏹\(nums)");
    return nums.count
}

/// 移除元素
/// - Parameters:
///   - nums: [0,0,1,1,1,1,2,3,3,4]
///   - val: 1
/// - Returns: [0,0,2,3,3,4]
func array_method_qes_4(_ nums: inout [Int],_ val: Int) -> Int {
    guard !nums.isEmpty else {
        return 0
    }
    var slow = 0;
    for fast in 0..<nums.count {
        if nums[fast] != val {
            nums[slow] = nums[fast]
            slow += 1
        }
        print("🌸\(nums)")
    }
    nums.removeSubrange(slow..<nums.count)
    return nums.count
}

/// 移除元素
/// - Parameters:
///   - nums: [0,0,1,1,1,1,2,3,3,4]
///   - val: 1
/// - Returns: [0,0,2,3,3,4]
//func array_method_qes_4(_ nums: inout [Int],_ val: Int) -> Int {
//    guard !nums.isEmpty else {
//        return 0
//    }
//    var left = 0,right = nums.count-1
//    while left < right {
//        if nums[left] == val {
//            nums[left] = nums[right]
//            right -= 1
//        } else {
//            left += 1
//        }
//        print("🌸\(nums)")
//    }
//    let fromIndex = nums[left] == val ? left : left+1
//    nums.removeSubrange(fromIndex..<nums.count)
//
//    print("end:\(nums)")
//    return nums.count
//}

/// 搜索插入位置
/// - Parameters:
///   - nums: [1,3,5,6]
///   - val: 5
/// - Returns: 2
func array_method_qes_5(_ nums: [Int],_ target: Int) -> Int {
    guard !nums.isEmpty else {
        return 0
    }
    var left = 0,right = nums.count-1;
    while left < right {
        let mid = left + (right-left)/2
        if target == nums[mid] {
            return mid
        } else if target < nums[mid] {
            right = mid - 1;
        } else {
            left = mid + 1
        }
    }
    
    return nums[left] < target ? left+1 : left
}
