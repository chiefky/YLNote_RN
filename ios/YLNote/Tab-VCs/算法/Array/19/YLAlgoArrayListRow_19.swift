//
//  YLAlgoArrayListRow_19.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 11. 旋转数组的最小数字
 把一个数组最开始的若干个元素搬到数组的末尾，我们称之为数组的旋转。
 给你一个可能存在 重复 元素值的数组 numbers，它原来是一个升序排列的数组，并按上述情形进行了一次旋转。请返回旋转数组的最小元素。例如，数组 [3,4,5,1,2] 为 [1,2,3,4,5] 的一次旋转，该数组的最小值为 1。
 注意，数组 [a[0], a[1], a[2], ..., a[n-1]] 旋转一次 的结果为数组 [a[n-1], a[0], a[1], a[2], ..., a[n-2]] 。
 
 示例 1：
 输入：numbers = [3,4,5,1,2]
 输出：1
 
 示例 2：
 输入：numbers = [2,2,2,0,1]
 输出：0
 
 提示：
 n == numbers.length
 1 <= n <= 5000
 -5000 <= numbers[i] <= 5000
 numbers 原来是一个升序排序的数组，并进行了 1 至 n 次旋转
 链接：https://leetcode.cn/problems/xuan-zhuan-shu-zu-de-zui-xiao-shu-zi-lcof/
 */
class YLAlgoArrayListRow_19: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let array = [3,4,5,1,2]
        let res = minArray(array)
        print("🍎结果：\(res)")
    }
    
    /// 时间复杂度 O(logN)
    /// 空间复杂度 O(1)
    /// - Parameter numbers: numbers
    /// - Returns: the minium
    func minArray(_ numbers: [Int]) -> Int {
        guard numbers.count > 1 else {
            return numbers.last ?? -1
        }
        var l = 0,r = numbers.count - 1
        
        while l < r {
            let mid = l + (r - l)/2
            if numbers[mid] > numbers[r] {
                l = mid + 1
            } else if numbers[mid] < numbers[r] {
                r = mid
            } else {
                r -= 1
            }
            print("🌹： \(numbers[l])...\(numbers[r])")
        }
        return numbers[r]
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_19"
    }
    
}
