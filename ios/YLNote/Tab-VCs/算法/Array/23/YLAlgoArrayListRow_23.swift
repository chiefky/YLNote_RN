//
//  YLAlgoArrayListRow_23.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 面试题40. 最小的k个数
 输入整数数组 arr ，找出其中最小的 k 个数。例如，输入4、5、1、6、2、7、3、8这8个数字，则最小的4个数字是1、2、3、4。

 示例 1：
 输入：arr = [3,2,1], k = 2
 输出：[1,2] 或者 [2,1]
 
 示例 2：
 输入：arr = [0,1,2,1], k = 1
 输出：[0]

 限制：
 0 <= k <= arr.length <= 10000
 0 <= arr[i] <= 10000
 
 */
class YLAlgoArrayListRow_23: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @objc func testMethod_1() {
        let arr = [0,1,2,1], k = 1
        let res = getLeastNumbers(arr,k)
        print("🍎结果：\(res)")
    }

    @objc func testMethod_2() {
        let arr = [0,1,2,1], k = 1
        let res = getLeastNumbers_quick_sort(arr, k)
        print("🍎结果：\(res)")
    }
    
    @objc func testMethod_3() {
        let arr = [0,1,2,1], k = 1
        let res = getLeastNumbers_quick_sort_optimize(arr,k)
        print("🍎结果：\(res)")
    }


    /// 系统排序算法
    /// 时间复杂度 O(NlogN)
    /// O(NlogN) ： 库函数、快排等排序算法的平均时间复杂度为 O(NlogN) 。
    /// 空间复杂度 O(N)O(N) ： 快速排序的递归深度最好（平均）为 O(logN) ，最差情况（即输入数组完全倒序）为O(N)。
    func getLeastNumbers(_ arr: [Int], _ k: Int) -> [Int] {
        guard arr.count > 1 else { return arr }
        let sort = arr.sorted()
        return Array(sort[0..<k])
    }
    
    var quick_sort_x = 0 // 分组次数
    /// 自己写排序算法（不加优化）
    /// 时间复杂度 O(NlogN)
    /// - Parameters:
    ///   - arr: arr
    ///   - k: k 元素个数
    /// - Returns: [0...k]
    func getLeastNumbers_quick_sort(_ arr: [Int], _ k: Int) -> [Int] {
        guard arr.count > 1 else { return arr }
        var tmp = arr
        quick_sort(&tmp, 0, arr.count-1)
        return Array(tmp[0..<k])
    }
    
    func quick_sort(_ arr:inout [Int], _ left: Int,_ right:Int ) {
        guard left < right else { return; }
        var l = left,r = right;
        while l < r {
            while l < r, arr[r] > arr[left] {
                r -= 1
            }
            while l < r, arr[l] <= arr[left] {
                l += 1
            }
            if l < r {
                arr.swapAt(l, r)
            }
        }
        arr.swapAt(left, l)
        quick_sort_x += 1
        print("🌹：分组\(quick_sort_x)次")
        quick_sort(&arr, left, l-1)
        quick_sort(&arr, l+1, right)
    }
    
    var quick_sort__optimize_x = 0 // 分组次数
    /// 自己写排序算法（不加优化）
    /// 时间复杂度 O(logN)
    /// - Parameters:
    ///   - arr: arr
    ///   - k: k 元素个数
    /// - Returns: [0...k]
    func getLeastNumbers_quick_sort_optimize(_ arr: [Int], _ k: Int) -> [Int] {
        guard arr.count > 1 else { return arr }
        var tmp:[Int] = arr
        quick_sort_optimize(&tmp, k,0,arr.count-1)
        return Array(tmp[0..<k])
    }
    
    /// 快排+划分数组
    /// - Parameters:
    ///   - arr: arr
    ///   - k: 元素个数
    ///   - left: 左起点
    ///   - right: 右终点
    func quick_sort_optimize(_ arr:inout [Int],_ k: Int, _ left: Int,_ right:Int) {
        guard left < right else { return; }
        var l = left, r = right
        while l < r {
            while l < r, arr[r] >= arr[left] {
                r -= 1
            }
            while l < r,arr[l] <= arr[left] {
                l += 1
            }
            arr.swapAt(l, r)
        }
        arr.swapAt(l, left)
        quick_sort__optimize_x += 1
        print("🌸：分组\(quick_sort__optimize_x)次")
        if l < k {
            quick_sort_optimize(&arr, k, l+1, right)
        }
        if l > k {
            quick_sort_optimize(&arr, k, left, l-1)
        }
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_23"
    }
    
}
