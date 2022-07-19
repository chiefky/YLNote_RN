//
//  day_test.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation

/**
 1. 中位数取值模糊不定（a+b)/2 、 （b-a+1)/2
 2. count 与中位数的比较，临界条件不确定
 3. mid 中位数指的是1...n中位数，既不是index也不是nums元素的中位数
 4. 数组中的元素包含1...n所有元素，另外多一个重复数字
 */
func array_0_algo_test(_ nums:[Int]) -> Int {
    var left = 1,right = nums.count - 1;
    while left < right {
        let mid = left + (right-left)/2
        var count = 0
        for num in nums {
            if num <= mid {
                count += 1;
            }
        }

        if count > mid {
            right = mid
        } else {
            left = mid + 1
        }
    }
    
    return left
}
/**
 
 */
func array_1_algo_test(_ nums:[Int]) -> Bool {
    let sorted = nums.sorted()
    for i in 1..<sorted.count {
        if abs(sorted[i] - sorted[i-1]) != 1 {
            return false
        }
    }
    return true
}
/**
 1. 忽略了条件同一个元素不能重复出现两次，idx2！= idx
 2. 利用哈希map存储target-num的下标，优化firstIndexOf，但是空间复杂度会增加至O(n)
 */
func array_2_algo_test(_ nums:[Int], target:Int) -> [Int] {
    var dic:[Int:Int] = [:]
    
    for (idx,num) in nums.enumerated() {
        //        if nums.contains(target-num) {
        //            let idx2 = nums.firstIndex(of: target-num)!
        //            if idx2 != idx {
        //                return [idx,idx2]
        //            }
        //        }

        if let idx2 = dic[target-num] {
            return [idx,idx2]
        } else {
            dic[num] = idx
        }
    }
    return []
}

/**
 1. 游标移动条件时机不确定：不同的话，游标先+1，后覆盖；相同的元素自动被过滤掉了
 2. 游标后面的元素没有删除
 */
func array_3_algo_test(_ nums:inout [Int]) -> Int {
    var vernier = 0
    for num in nums {
        if nums[vernier] != num {
            vernier += 1
            nums[vernier] = num
        }
    }
    nums.removeSubrange(vernier+1..<nums.count) // 这一步遗忘了
    print("::\(nums)")
    let count = vernier+1
    return count
}

/**
 1. 注意游标+1 的时机，以及返回结果不需要再+1
 */
func array_4_algo_test(_ nums:inout [Int],target: Int) -> Int {
    var vernier = 0
    for num in nums {
        if target != num {
            nums[vernier] = num
            vernier += 1;
        }
    }
    nums.removeSubrange(vernier..<nums.count)
    print("::\(nums)")
    let count = vernier
    return count
}
/**
 1. target < nums[left] 返回结果应该是left，不是left-1
 */
func array_5_algo_test(_ nums:[Int], target: Int) -> Int {
    var left = 0, right = nums.count-1
    while left < right {
        let mid = left + (right - left)/2
        if target == nums[mid] {
            return mid
        } else if target < nums[mid] {
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return target > nums[left] ? (left + 1) : left
}
/**
 1. 思路混乱；子数组‘连续’的隐藏条件：当遍历到第i个元素时，以当前节点为最后节点的子数组最大和
 2. 改动：返回最大和连续子数组的下标
 */
func array_6_algo_test(_ nums:[Int]) -> [Int] {
    var maxSum_i = 0 // 当遍历到第i个元素时，以当前节点为最后节点的子数组最大和
    var children_i:[Int] = [] //当遍历到第i个元素时，以当前节点为最后节点的子数组元素下标
    var maxSum = nums[0]
    var children:[Int] = []
    
    for (idx,num) in nums.enumerated() {
        if maxSum_i > 0 {
            maxSum_i += num
            children_i.append(idx)
        } else {
            maxSum_i = num
            children_i = [idx];
        }
        
        if maxSum_i > maxSum {
            maxSum = maxSum_i // 第i步的最大值再跟以前记录的最大值比较
            children = children_i; // 更新子数组
        }
    }
    return children
}

func array_6_algo_test_origin(_ nums:[Int]) -> Int {
    var maxSum_i = 0 // 当遍历到第i个元素时，以当前节点为最后节点的子数组最大和
    var maxSum = nums[0]
    for num in nums {
        
        if maxSum_i > 0 {
            maxSum_i += num
        } else {
            maxSum_i = num
        }
        
        if maxSum_i > maxSum {
            maxSum = maxSum_i // 第i步的最大值再跟以前记录的最大值比较
        }
    }
    return maxSum
}

/**
 1. 没有想到取余运算，一顿if判断+1
 2. 遗漏数组非空判断
 */
func array_7_algo_test(_ nums: [Int]) -> [Int] {
    guard !nums.isEmpty else {
        return []
    }
    var high = nums.count-1
    var res = nums
    while high >= 0 {
        res[high] = (res[high] + 1)%10
        if res[high] != 0 {
            return res
        }
        high -= 1
    }
    if res[0] == 0 {
         res.insert(1, at: 0)
    }
    return res
}

/**
 1. 比较大小插入的方法不可取，nums1中存在有效的0 和无效的0，通过过滤方法不可取，只能交换
 2. 注意临界条件
 */
func array_8_algo_test(_ nums1:inout [Int],m:Int,_ nums2: [Int],n:Int) {
    var i = m+n-1
    var m = m-1
    var n = n-1
    while n >= 0 {
        while m>=0,nums1[m]>nums2[n] {
            nums1[i] = nums1[m]
            m -= 1
            i -= 1
        }
        nums1[i] = nums2[n]
        n -= 1
        i -= 1
        
        print("🌸：\(nums1)")
    }
}

/**
 1. 初始化lineNums存n个1（创建一个初始化大小数组的语法：var someArray = [SomeType](repeating: InitialValue, count: NumbeOfElements)）
 2. 修改内层元素value
 */
func array_9_algo_test(_ n:Int) -> [[Int]] {
    if n <= 0 {
        return []
    }
    var res:[[Int]] = []
    for i in 0..<n {
        var currentLineNums = [Int](repeating: 1, count: i+1)
        print("\(i):\(currentLineNums)");
        if i>1 {
            let preLineNums = res[i-1]
            for j in 1..<n-1 {
                currentLineNums[j] = preLineNums[j] + preLineNums[j-1]
            }
        }
        print("🌸\(i):\(currentLineNums)");
        res.append(currentLineNums);

    }
    return res;
}

/**
 1. 此方法为双循环时间复杂度为O(n^2)，提示超时
 */
func array_10_algo_test(_ nums:[Int]) -> Int {
    var res = 0
    var max_i = 0
    for i in 0..<nums.count-1 {
        var j = i+1
        while j <= nums.count-1 {
            let dis = nums[j] - nums[i]
            max_i = max(max_i, dis)
            j += 1;
        }
        res = max(res, max_i);
    }
    
    return res
}

/**
 只记录最低谷价格，之后只考虑num[i]与与最低价格的差值与记录的最大值比较即可
 */
func array_10_algo_test_optimal(_ nums:[Int]) -> Int {
    var res = 0
    var princeMin = Int.max
    for i in 0..<nums.count-1 {
        if nums[i] < princeMin {
            princeMin = nums[i];
        } else if (nums[i] - princeMin > res) {
            res = nums[i] - princeMin;
        }
        
    }
    
    return res
}

//func isEqual(_ a:Character, _ b:Character) -> Bool {
//    if a.isNumber && b.isNumber {
//        return a==b
//    } else if a.isLetter && b.isLetter {
//        return a.lowercased() == b.lowercased()
//    }
//    return false
//}

/**
 字符串转成数组，逆序后比较是否相等(注意大小写问题)
 */
func array_11_algo_test_a(_ str:String) -> Bool {
    let chars:[Character] = Array(str.lowercased()).filter { $0.isNumber || $0.isLetter }
    let reversedChars:[Character] = chars.reversed()
    if chars == reversedChars {
        return true
    }
    return false
}
/**
 判断左右指针所指向的字符是否相等，注意区分字母（大小写）、数字
 */
func array_11_algo_test_b(_ str:String) -> Bool {
    let chars:[Character] = Array(str.lowercased()).filter { $0.isNumber || $0.isLetter }
    guard chars.count > 0 else {
        return true
    }

    var left = 0,right = chars.count-1
    while left < right {
        if chars[left] != chars[right] {
            return false;
        }
        left += 1
        right -= 1
    }
    return true
}
/**
 利用同一个数异或偶数次为0的性质
 */
func array_12_algo_test_0(_ nums: [Int]) -> Int {
    var res = 0
    for num in nums {
        res ^= num
    }
    return res
}

//func array_12_algo_test_1_a(_ nums: [Int]) -> [Int] {
//    if nums.count <= 2 {
//        return nums
//    }
//    let tmp:[Int] = nums.sorted()
//    var res:[Int] = [];
//    for i in 0..<tmp.count-1 {
//        if i==0, tmp[i] != tmp[i+1] {
//            res.append(tmp[i])
//        } else if i==tmp.count-1, tmp[i] != tmp[i-1] {
//            res.append(tmp[i])
//        } else if i > 1,i < tmp.count-1 {
//            if tmp[i] != tmp[i-1] && tmp[i] != tmp[i+1] {
//                res.append(tmp[i])
//            }
//        }
//        print("🌸\(i):\(res)")
//    }
//    return res
//}

/**
 利用字典记录下出现num的下标，再次遍历到同一num时移除记录下的下标，最终返回dic的keys即可
 */
func array_12_algo_test_1_a(_ nums: [Int]) -> [Int] {
    if nums.count <= 2 {
        return nums
    }

    var marked:[Int:Int] = [:]
    for (index,num) in nums.enumerated() {
        if let _ = marked[num] {
            marked[num] = nil;
        } else {
            marked[num] = index
        }
        print("🌸\(index):\(marked)")
    }
    return Array(marked.keys)
}

/**
 所有数异或的值==唯二两数的异或值，找出异或值二进制为1的第k位,遍历所有数满足第k位是1的数为1组，剩下的为另一组，两组分别取异或得到的结果分别是v1,v2
 */
func array_12_algo_test_1_b(_ nums: [Int]) -> [Int] {
    var xor = 0
    var v1 = 0,v2 = 0
    
    for num in nums {
        xor ^= num
    }
    
    var x = xor
    var k = 0 // xor的第k位是1
    while x&1 == 0 {
        x >>= 1
        k += 1
    }
   
    for num in nums {
        let tmp = num>>k
        if tmp&1 == 1 {
            v1 ^= num
        } else {
            v2 ^= num
        }
    }
    return [v1,v2];
}
/**
 Int 在swift中取的是当前设备的编码位数
 每位累加的结果对3取余就是目标值当前位的值
 结果值：对非0位的值左移运算后或运算 { 第k位是1，res = res | (1<<k)}
 */
func array_12_algo_test_2(_ nums:[Int]) -> Int {
    var res = 0
    for i in 0...64 {
        var sum_i = 0
        for num in nums {
            let tmp = (num>>i)&1
            sum_i += tmp
        }
        if sum_i%3 == 1 {
            res |= 1<<i
        }
    }
    return res
}


/**
 头插法：（在current位置断开，分裂成两个链表）初始化一个新的空节点，从旧的链表上摘除节点插入到新的链表的new_head位置
 */
func linklist_0_algo_test_a(_ head:ListNode?) -> [Int] {
    guard let head = head else { return [] }
    var new_head:ListNode? = nil, current:ListNode? = head
    while current != nil {
        print("🍓：\(current!.val)")
        let tmp = current!
        current = current!.next
        tmp.next = new_head
        new_head = tmp
    }
    
    var res:[Int] = []
    var reversed_cur:ListNode? = new_head
    while reversed_cur != nil {
        res.append(reversed_cur!.val)
        reversed_cur = reversed_cur!.next
    }
    
    return res
}

/**
 两两交换：在原来的链表里修改指针的指向，修改完指针指向将新的头结点赋值
 */
func linklist_0_algo_test_b(_ head:ListNode?) -> [Int] {
    guard var new_head = head else { return [] }
    let ahead = new_head
    while ahead.next != nil {
        let temp = ahead.next!
        ahead.next = ahead.next?.next
        temp.next = new_head
        new_head = temp
    }
    
    var res = [Int]()
    var reversed_head:ListNode? = new_head
    while reversed_head != nil {
        res.append(reversed_head!.val)
        reversed_head = reversed_head?.next
    }
    
    return res
}

/**
 ---------以上-----
 */
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
