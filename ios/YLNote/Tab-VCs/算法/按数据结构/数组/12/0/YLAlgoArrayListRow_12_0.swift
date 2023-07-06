//
//  YLAlgoArrayListRow_12_0.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。
 说明：
 你的算法应该具有线性时间复杂度。 你可以不使用额外空间来实现吗？
 示例 1:
 输入: [2,2,1]
 输出: 1

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/single-number
 */

class YLAlgoArrayListRow_12_0: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        
        let arr = [4,1,2,1,2]//"A man, a plan, a anal: Panama";
        let res = singleNumber(arr)
        print("结果：\(res)")
    }
    
    /// 时间复杂度：O(n)，空间复杂度：O(1)
    /// 按位运算（异或）
    func singleNumber(_ nums: [Int]) -> Int {
        var res = 0;
        for num in nums {
            res ^= num;
            
        }
        return res;
    }
    
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_12_0"
    }

}
