//
//  YLAlgoSwapListController.swift
//  YLNote
//
//  Created by tangh on 2022/5/30.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlgoBinarySearchListController: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - 剑指 Offer 11. 旋转数组的最小数字
    @objc func bs_minArray()  {
        let nums = [3,4,5,5,5,5,1,2]
        let res = bs_minArray(nums)
        print("二分查找旋转数组的最小值：\(res)");
    }
    
    ///旋转数组的最小数字
    ///时间复杂度：O(log(N)) ；空间复杂度：O(1)
    /// - Parameter numbers: 旋转后的数组
    /// - Returns: 最小数字
    func bs_minArray(_ numbers: [Int]) -> Int {
        var l = 0, r = numbers.count - 1
        while l < r {
            let mid = l + (r-l)/2
            if numbers[mid] > numbers[r] {
                l = mid + 1;
            } else if numbers[mid] < numbers[r] {
                r = mid
            } else {
                r -= 1
            }
        }
        return numbers[l]
    }
    // MARK: 33. 搜索旋转排序数组
    @objc func bs_search()  {
        let nums = [4,5,6,7,0,1,2]
        let res = search(nums, 3)
        print(" 搜索旋转排序数组，下标：\(res)")
    }
    
    /// 时间复杂度：O(log(n))；空间复杂度O(1)；
    /// - Parameters:
    ///   - nums: 数组
    ///   - target: 目标数字
    /// - Returns: 下标
    func search(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 1 else {
            return nums.first == target ? 0 : -1
        }
        var l = 0,r = nums.count-1
        while l < r {
            let mid = l + (r-l)/2
            if nums[mid] == target {
                return mid
            }
            if nums[mid] >= nums[l] {
                if target >= nums[l] && target < nums[mid] {
                    r = mid - 1
                } else {
                    l = mid + 1
                }
            } else {
                if target > nums[mid] && target <= nums[r] {
                    l = mid + 1
                } else {
                    r = mid - 1
                }
            }
        }
        return -1
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_binary_search_list"
    }

}
