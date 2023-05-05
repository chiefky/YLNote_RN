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
        let res = threeSum(array)
        print("🍎结果：\(res)")
    }
    
    /// 时间复杂度：O(n^2)，空间复杂度：O(1)；忽略了排序的复杂度
    /// 排序+双指针
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let nums = nums.sorted();
        var res:[[Int]] = [];
        let n = nums.count;
        guard let first = nums.first,let last = nums.last else { return [] }
        if first > 0 || last < 0  {
            return [];
        } else if first == last,first == 0 {
            return [[0,0,0]];
        } else {
            for first in 0...n-1 {
                if first>0,nums[first] == nums[first-1] {
                    continue;
                }
                
                var l = first+1,r = n - 1;
                let target = 0 - nums[first];
                while l < r {
                    if nums[l]+nums[r] < target {
                        l += 1
                    } else if nums[l]+nums[r] > target {
                        r -= 1
                    } else {
                        // 先去重，找到最右面的left有效位和最左面的right有效位
                        while l<r,nums[l] == nums[l+1] {
                            l += 1
                        }
                        while l<r,nums[r] == nums[r-1] {
                            r -= 1;
                        }
                        res.append([nums[first],nums[l],nums[r]]);
                        // 添加完有效结果后，左右区间个缩进1个位置
                        l += 1;
                        r -= 1;
                    }
                }
            }
        }
        return res;
    }

    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_17"
    }
  
}
