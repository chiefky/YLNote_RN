//
//  YLAlgoBitListRow_3.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
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
 
 示例 2:
 输入: [4,1,2,1,2]
 输出: 4

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/single-number
 */


class YLAlgoBitListRow_3: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let res = method_1([2,2,1])
        print("🍎1：\(res)")

    }
    
    
    /// 时间复杂度：O(log n), 空间复杂度： O(1)。
    /// - Parameter num: <#num description#>
    /// - Returns: <#description#>
    func method_1(_ nums:[Int]) -> Int {
        var m = 0
        for num in nums {
            m ^= num
        }
        return m;
    }

    //MARK: override
    override func fileName() -> String {
        return "Algo_bit_row_3"
    }
}
