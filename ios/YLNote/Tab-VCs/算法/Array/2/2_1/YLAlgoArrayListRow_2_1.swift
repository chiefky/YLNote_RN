//
//  YLAlgoArrayListRow_2.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
import CloudKit
/**
 给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。
 你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。
 你可以按任意顺序返回答案。

 链接：https://leetcode.cn/problems/two-sum
 */

class YLAlgoArrayListRow_2_1: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func testMethod1() {
        let array = [11,13,12,1,3,4]
        let res = twoSum(array, 13);
        print("结果：\(res)")
    }
    
    /// 时间复杂度: O(n)，空间复杂度：O(n)
    /// 使用哈希表，利用哈希表key的唯一性以及快速取值特性，降低时间复杂度
    /// key:数组中的元素作为key, value：元素对应的索引值为value；遍历过程中如果哈希表中如果不存在当前元素的搭档执行插入操作(将自身插入哈希表，下次查遍历到搭档时，就可以直接将当前元素和搭档元素的索引一并返回了),
    /// - Parameters:
    ///   - nums: 任意数组
    ///   - target: 目标和
    /// - Returns: 任意满足和为target的组合元素的索引
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dic:[Int:Int] = [:]
        for (idx,num) in nums.enumerated() {
            let another = target - num;
            if let j = dic[another] {
                return [idx,j];
            } else {
                dic[num] = idx;
            }
        }
        return [];
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_2_1"
    }
}
