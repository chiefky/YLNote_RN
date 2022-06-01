//
//  YLAlgoArrayListRow_6.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给你一个整数数组 nums，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
 子数组 是数组中的一个连续部分。

 链接：https://leetcode.cn/problems/maximum-subarray/
 */

class YLAlgoArrayListRow_6: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let array = [-2,1,-3,4,-1,2,1,-5,4]
        let res = method_1(array);
        print("结果：\(res)")
    }

    
    func method_1(_ nums: [Int]) -> (Int) {
        if nums.isEmpty {
            return (0);
        }
        var preSum = 0
        var maxvalue = 0
        for num in nums {
            preSum = max(preSum+num, num)
            maxvalue = max(preSum, maxvalue)
        }
        return maxvalue
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_6"
    }
    
}
