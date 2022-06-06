//
//  YLAlgoArrayListRow_12_2.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给你一个整数数组 nums ，除某个元素仅出现 一次 外，其余每个元素都恰出现 三次 。请你找出并返回那个只出现了一次的元素。

 示例 1：
 输入：nums = [2,2,3,2]
 输出：3

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/single-number-ii
 */

class YLAlgoArrayListRow_12_2: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        
        let arr = [-2,-2,1,1,4,1,4,4,-4,-2];
        let res = method_1(arr)
        print("结果：\(res)")
    }
    @objc func testMethod_2() {
        let arr = [2,2,3,2];
        let res = method_2(arr)
        print("结果：\(res)")
    }

    /// 按位求和运算得到有效数字当前位是0或1，若当前位为1,拼上之前的i-1位更新结果(或运算)
    /// 时间复杂度（）
    /// - Parameter nums:
    /// - Returns:
    func method_1(_ nums: [Int]) -> Int {
        var res = 0
        for i in 0...64 {
            var total = 0
            for num in nums {
                total += (num>>i) & 1
            }
            if (total%3==1) {
                res |= (1<<i)
            }
        }
        return res;
    }
    
    func method_2(_ nums: [Int]) -> Int {
        var dic:[Int:Int] = [:]
        for num in nums {
            if dic.keys.contains(num) {
                var count:Int = dic[num] ?? 0
                count += 1
                dic[num] = count
            } else {
                dic[num] = 1
            }
        }
        
        for (key,value) in dic {
            if value == 1 {
                return key
            }
        }
        return 0;
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_12_2"
    }

}
