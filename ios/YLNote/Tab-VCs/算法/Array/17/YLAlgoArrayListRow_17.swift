//
//  YLAlgoArrayListRow_17.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 15. 三数之和
 给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有和为 0 且不重复的三元组。
 注意：答案中不可以包含重复的三元组。
  
 示例 1：
 输入：nums = [-1,0,1,2,-1,-4]
 输出：[[-1,-1,2],[-1,0,1]]
 
 示例 2：
 输入：nums = []
 输出：[]
 
 示例 3：
 输入：nums = [0]
 输出：[]

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/3sum
 
 */

class YLAlgoArrayListRow_17: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let array = [-2,-1,0,1,1,3,2,-1,-4]
        let res = method_three_pointer(array)
        print("🍎结果：\(res)")
    }
    
    func method_three_pointer(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 2 else {
            return []
        }
        let sorted_nums = nums.sorted()
        print("started:\(sorted_nums)")
        if sorted_nums.first! > 0 || sorted_nums.last! < 0 {
            return []
        } else if sorted_nums.first! == sorted_nums.last!,sorted_nums.first! == 0 {
            return [[0,0,0]]
        } else {
            var res:[[Int]] = []
            for i in 0..<sorted_nums.count {
                if i > 0 , sorted_nums[i] == sorted_nums[i-1] {
                    continue
                }
                var l = i + 1, r = sorted_nums.count - 1
                while l < r {
                    let sum = sorted_nums[i] + sorted_nums[l] + sorted_nums[r]
                    if sum > 0 {
                      r -= 1
                    } else if sum < 0 {
                        l += 1
                    } else {
                        res.append([sorted_nums[i],sorted_nums[l],sorted_nums[r]])
                        while r > l, sorted_nums[r] == sorted_nums[r-1] {
                            r -= 1
                        }
                        while l < r, sorted_nums[l] == sorted_nums[l+1] {
                            l += 1
                        }
                        l += 1;
                        r -= 1
                    }
                }
                print("\(i),🌹：\(res)")
            }
            return res;
        }
       }

    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_17"
    }
  
}
