//
//  YLAlgoArrayListRow_16.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 
 剑指 Offer 39. 数组中出现次数超过一半的数字
 数组中有一个数字出现的次数超过数组长度的一半，请找出这个数字。
 你可以假设数组是非空的，并且给定的数组总是存在多数元素。


 示例 1:
 输入: [1, 2, 3, 2, 2, 2, 5, 4, 2]
 输出: 2
  
 https://leetcode.cn/problems/shu-zu-zhong-chu-xian-ci-shu-chao-guo-yi-ban-de-shu-zi-lcof/
 */

class YLAlgoArrayListRow_16: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let array = [1, 2, 3, 2, 2, 2, 5, 4, 2,2,9]
        let res = method_map(array)
        print("🍎结果：\(res)")
    }
    
    @objc func testMethod_2() {
        let array = [1, 2, 3, 2, 2, 2, 5, 4, 2,2,9]
        let res = method_vote(array)
        print("🍎结果：\(res)")
    }
    

    func method_map(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else {
            return -1
        }
        var count:[Int:Int] = [:]
        var max_count = 0
        var res = 0
        
        for num in nums {
            let tmp = count[num] ?? 0
            count[num] = tmp + 1
            if count[num]! > max_count {
                max_count = count[num]!
                res = num
            }
            print("🌸：\(num):\(count[num]!)/\(max_count)")
        }
        return res
    }
    
    func method_vote(_ nums:[Int]) -> Int {
        var vote = 0
        var vote_sum = 0
        
        for num in nums {
            if vote_sum == 0 {
                vote = num
            }
            
            vote_sum += vote == num ? 1 : -1
            print("🌸：\(num):\(vote),\(vote_sum)")
        }
        
        return vote
    }
    
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_16"
    }
  
}
