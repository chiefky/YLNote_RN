//
//  YLAlgoArrayListRow_15.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 
 给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。
 请注意 ，必须在不复制数组的情况下原地对数组进行操作。
 
 示例 1:
 输入: nums = [0,1,0,3,12]
 输出: [1,3,12,0,0]
 示例 2:

 输入: nums = [0]
 输出: [0]
 https://leetcode.cn/problems/move-zeroes/
 */

class YLAlgoArrayListRow_15: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        var array = [0,1,0,3,12]
         method_1(&array);
        print("🍎结果：\(array)")
    }
    func method_1(_ nums: inout [Int]) {
         var slow = 0
         for fast in 0..<nums.count {
             if nums[fast] != 0 {
                 nums.swapAt(fast, slow)
                 slow += 1
             }
             print("🌸：\(nums)")
         }
     }
    

    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_15"
    }
  
}
