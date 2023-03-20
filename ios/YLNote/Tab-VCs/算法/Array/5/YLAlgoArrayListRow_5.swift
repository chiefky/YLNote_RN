//
//  YLAlgoArrayListRow_5.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。
 请必须使用时间复杂度为 O(log n) 的算法。

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/search-insert-position
 */

class YLAlgoArrayListRow_5: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let array = [0,1,2,3,5,9]
        let res = searchInsert(array,6);
        print("结果：\(res)")
    }

    /// 时间复杂度：O(lgn)，空间复杂度：O(1)
    /// 二分查找
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var left = 0,right = nums.count-1;
        while left <= right {
            let mid = left + (right-left)/2;
            if target == nums[mid] {
                return mid;
            } else if target > nums[mid] {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_5"
    }
}
