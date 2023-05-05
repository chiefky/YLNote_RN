//
//  YLAlgoArrayListRow_6.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给你一个整数数组nums，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
 子数组 是数组中的一个连续部分。

 链接：https://leetcode.cn/problems/maximum-subarray/
 */

class YLAlgoArrayListRow_6: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let array = [1,-1,3]//[-2,1,-3,4,-1,2,1,-5,4]
        let res = maxSubArray(array);
        print("结果：\(res)")
    }
    
    /// 时间复杂度：O(n），空间复杂度：O(1)
    /// 动态规划
    func maxSubArray(_ nums: [Int]) -> Int {
        var subSum = nums[0],preSum = 0;
        var subArray:[Int] = [],preSubArray:[Int] = [];
        for num in nums {
            if num >= preSum+num {
                preSubArray = [num];
            } else {
                preSubArray.append(num);
            }
            preSum = max(preSum+num, num);
            
            if preSum > subSum {
                subArray = preSubArray;
            }
            subSum = max(preSum, subSum);
            print("🌹(\(num))|\(preSubArray)");
        }
        print("最大和的连续子数组为\(subArray)");
        return subSum;
    }

        
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_6"
    }
    
}
