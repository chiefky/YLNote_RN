//
//  day_test_array.swift
//  YLNote
//
//  Created by tangh on 2022/6/19.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation

//MARK: 0
///  寻找重复数
/// - Parameter nums: [1,3,4,2,2]
/// - Returns: 2
func array_qes_0(_ nums:[Int]) -> Int {
    guard nums.count > 2 else {
        return nums.first ?? -1
    }
    print("🔢：\(nums)")
    var l = 1, r = nums.count - 1
    while l < r {
        let mid = l + (r - l)/2
        print("数字区间：[\(l)...\(r)]， 中位数：\(mid)")
        var count = 0
        for num in nums {
            // 小于中位数的个数
            if num <= mid {
                count += 1
            }
        }
        print("原始数组中 ≤\(mid) 的个数：\(count)")
        if count > mid {
            r = mid
        } else {
            l = mid + 1
        }
    }
    return l
}

//MARK: 1
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
//MARK: 2
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

//MARK: 6
func array_qes_6(_ nums: [Int]) -> Int {
    if nums.isEmpty {
        return 0
    }
    var maxSum = nums[0], preMax = nums[0]
    for i in 1..<nums.count {
        preMax = max(preMax+nums[i], nums[i])
        maxSum = max(maxSum,preMax)
    }
    return maxSum
}

//MARK: 10
func array_qes_10(_  prices: [Int]) -> Int {
    if prices.count < 2 {
        return 0
    }
    var maxProfit = 0, preMin = prices[0]
    for i in 0..<prices.count {
        preMin = min(preMin, prices[i])
        maxProfit = max(maxProfit, prices[i] - preMin)
    }
    return maxProfit
}

//MARK: 7
func array_qes_7(_ digits:[Int]) -> [Int] {
    var res = digits;
    for i in (0..<digits.count).reversed() {
        res[i] = (digits[i] + 1) % 10
        if res[i] != 0 {
            return res
        }
    }

    if res[0] == 0 {
        res.insert(1, at: 0)
    }
    return res
}
//MARK: 8
func array_qes_8(_ nums1:inout [Int],_ m: Int, _ nums2:[Int], _ n:Int) {
    var p1 = m-1,p2 = n-1;
    var p = m + n - 1;
    while p1 >= 0 || p2 >= 0 {
        if p1 == -1 {
            nums1[p] = nums2[p2]
            p2 -= 1
        } else if p2 == -1 {
            nums1[p] = nums1[p1]
            p1 -= 1
        } else if nums1[p1] > nums2[p2] {
            nums1[p] = nums1[p1]
            p1 -= 1
        } else {
            nums1[p] = nums2[p2]
            p2 -= 1
        }
        p -= 1
    }
}
//MARK: 9
func array_qes_9(_ numRows:Int) -> [[Int]] {
    var res:[[Int]] = [];
    for i in 0..<numRows {
        var line = Array(repeating: 1, count: i+1);
        var j = 1
        while j < i {
            let preLine = res[i-1]
            line[j] = preLine[j] + preLine[j-1]
            j += 1
        }
        res.append(line)
    }
    return res
    
}

//MARK: 12
func array_qes_12_0(_ nums:[Int]) -> Int {
    var res = 0
    for num in nums {
        res ^= num
    }
    return res
}

func array_qes_12_1(_ nums:[Int]) -> [Int] {
    guard nums.count >= 2 else {
        return []
    }
    
    var xor = 0
    for num in nums {
        xor ^= num
    }
    
    var x = xor,k = 0
    while x&1 == 0 {
        x >>= 1
        k += 1
    }
    var v1 = 0,v2 = 0
    for num in nums {
        let value = num>>k
        if(value&1) == 1 {
            v1 ^= num
        } else {
            v2 ^= num
        }
    }
    return [v1,v2]
}

func array_qes_12_2(_ nums:[Int]) -> Int {
    guard nums.count > 2 else {
        return nums.first ?? -1
    }
    var i = 0,res=0
    while i < 64 {
        var sum = 0
        for num in nums {
            let tmp = num >> i
            let bit_i = tmp & 1
            sum += bit_i
        }
        
        if sum%3 == 1 {
            res = 1<<i | res
        }
        i += 1
    }
    return res
}

//MARK: 13
func array_qes_13(_ nums:[Int]) -> [Int] {
    var res:[Int] = []
    var left = 0,right = nums.count - 1
    while left < right {
        if abs(nums[left]) > abs(nums[right]) {
            res.append(nums[left]*nums[left])
            left += 1
        } else {
            res.append(nums[right]*nums[right])
            right -= 1
        }
    }
    res.append(nums[left]*nums[left])
    return res.reversed()
}

//MARK: 15
func array_qes_15(_ nums: inout [Int]) {
    var slow = 0
    for fast in 0..<nums.count {
        if nums[fast] != 0 {
            nums.swapAt(fast, slow)
            slow += 1
        }
    }
}

//MARK: 16
func array_qes_16(_ nums: inout [Int]) -> Int {
    let tmp = nums.sorted()
    return tmp[(nums.count-1)/2]
}

//MARK: 17
func array_qes_17(_ nums: [Int]) -> [[Int]] {
    guard nums.count > 2 else { return [] }
    let sorted = nums.sorted()
    if sorted.first! > 0 || sorted.last! < 0 {
        return []
    }
    var res:[[Int]] = []
    for first in 0..<sorted.count {
        if first > 0,sorted[first] == sorted[first-1] {
            continue
        }
        var second = first + 1,third = sorted.count - 1
        while second < third {
            let last = 0 - sorted[first] - sorted[second]
//            print("🌹：\([sorted[first],sorted[second],sorted[third]])：\(last == sorted[third])")
            if sorted[third] == last {
                res.append([sorted[first],sorted[second],sorted[third]])
                while second < third, sorted[third] == sorted[third-1] {
                    third -= 1
                }
                while second < third, sorted[second] == sorted[second+1] {
                        second += 1
                }
                
                third -= 1
                second += 1
            } else if last < sorted[third] {
                third -= 1
            } else {
                second += 1
            }
        }
    }
    
    return res
    
}

//MARK: 18
func array_qes_18(_ matrix: [[Int]], _ target:Int) -> Bool {
    guard let fisrtline = matrix.first, !fisrtline.isEmpty else { return false }
    let n = matrix.count, m = fisrtline.count
    var i = 0,j = m-1
    while i < n,j >= 0 {
//        print("🌹：\(i),\(j):\(matrix[i][j])")
        if matrix[i][j] == target {
            return true
        } else if matrix[i][j] > target {
            j -= 1
        } else {
            i += 1
        }
    }
    return false
}

//MARK: 14
func array_qes_14(_ nums: inout [Int], _ k:Int)  {
    let n = nums.count
    guard n > 0 else { return  }
    let k = k%n;
    reverseArray(&nums, 0, n-1)
    reverseArray(&nums, 0, k-1)
    reverseArray(&nums, k, n-1)
}

func reverseArray(_ nums: inout [Int], _ start: Int,_ end: Int) {
    var l = start,r = end
    while l < r {
        nums.swapAt(l, r)
        l += 1
        r -= 1
    }
    print("🌹：\(nums)")
}

//MARK: 19
func array_qes_19(_ nums: [Int]) -> Int {
    if nums.isEmpty {
        return -1
    }
    var l = 0,r = nums.count-1
    while l < r {
        let mid = l + (r-l)/2
        if nums[mid] > nums[r] {
            l = mid + 1
        } else  if nums[mid] < nums[r] {
            r = mid
        } else {
            r -= 1
        }
    }
    return nums[r]
}

//MARK: 20
var result:[Int] = []
func array_qes_20(_ n:Int)  {
    var chars = [String](repeating: "0", count: n)
    dfs(&chars, 0, n)
}

func dfs(_ chars: inout [String],_ index: Int,_ n:Int) {
    if index == n {
        let str = chars.joined(separator: "")
        if let num =  Int(str),num != 0 {
            result.append(num)
        }
        return
    }
    for i in ["0","1","2","3","4","5","6","7","8","9"] {
        chars[index] = i
        dfs(&chars, index+1, n)
    }
}

//MARK: 21
func array_qes_21(_ nums: [Int]) -> [Int] {
    var nums = nums
    var l = 0,r = nums.count - 1
    while l < r {
        if l < r, nums[r] % 2 == 0 {
            r -= 1
        }
        if l < r, nums[l] % 2 == 1 {
            l += 1
        }
        if l < r {
            nums.swapAt(l, r)
            l += 1
            r -= 1
        }
    }
    return nums
}

//MARK: 22
func array_qes_22(_ nums: [[Int]]) -> [Int] {
    guard let firstline = nums.first,firstline.count > 0 else { return [] }
    let m = nums.count, n = firstline.count
    var top = 0,left = 0 ,bottom = m - 1,right = n - 1
    var res:[Int] = []
    while true {
        // top: 左->右,修改上限
        for i in left...right {
            res.append(nums[top][i])
        }
        if top + 1 > bottom { break }
        top += 1
        
        // right: 上->下，修改右边界
        for i in top...bottom {
            res.append(nums[i][right])
        }
        if right-1 < left { break }
        right -= 1

        // bottom: 右->左，修改下限
        for i in (left...right).reversed() {
            res.append(nums[bottom][i])
        }
        if bottom-1 < top { break }
        bottom -= 1

        // left: 下->上，修改左边界
        for i in (top...bottom).reversed() {
            res.append(nums[i][left])
        }
        if left+1 > right { break }
        left += 1
    }
    return res
}

//MARK: 22
func array_qes_23(_ nums: [Int],_ k: Int) -> [Int] {
    guard nums.count > k else {
        return nums
    }
    var arr = nums
    print("🌲：\(nums)")
    quick_sort(&arr, 0, nums.count-1, k)
    return Array(arr[0..<k])
}

/// 快速排序优化
/// - Parameters:
///   - nums: 待排序数组
///   - start: 待排序区间 起点
///   - end: 待排序区间 终点
///   - k: topK 中的k的取值
func quick_sort(_ nums: inout [Int], _ start: Int,_ end: Int,_ k: Int )  {
    guard start < end else { return  }
    var l = start, r = end
    while l < r {
        while l < r, nums[r] >= nums[start] {
            r -= 1
        }
        while l < r, nums[l] <= nums[start] {
            l += 1
        }
        nums.swapAt(l, r)
    }
    nums.swapAt(start, l)
    if l == k-1 {
         return
    } else if l > k-1 {
        quick_sort(&nums, start, l-1, k)
    } else {
        quick_sort(&nums, l+1, end, k)
    }
}

func singleNumbers(_ nums: [Int]) -> Int {
    var k = 0
    var res = 0
    while k < 64 {
        var sum_k = 0
        for num in nums {
            let tmp = (num >> k) & 1
            sum_k += tmp
        }
        if sum_k % 3 != 0 {
            res |= 1<<k
        }
        k += 1
    }
    return res
}

func testArray()  {
    let nums = [1,2,1,3,2,5];
    let res = singleNumbers(nums)
    print("👨‍👩‍👧‍👦结果：\(res)")
}
